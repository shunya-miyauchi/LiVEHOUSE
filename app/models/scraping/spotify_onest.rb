class Scraping::SpotifyOnest < ApplicationRecord
  require 'open-uri'

  class << self
    # データベース保存
    def import
      events = event_details
      result =
        Event.import events,
                     validate_uniqueness: true,
                     on_duplicate_key_update: {
                       constraint_name: :for_upsert,
                       columns: %i[title open price artist]
                     }
      p result.failed_instances
    end

    private

    # 月毎のURL取得
    def monthly_urls
      date = Date.current
      month_urls = []
      3.times do |_f|
        year = date.year
        month = date.month
        month_urls << "https://shibuya-o.com/nest/schedule/?y=#{year}&m=#{month}/"
        date = date.next_month
        date = date.next_year if date.month == 1
      end
      month_urls
    end

    # イベント毎のURL取得
    def day_links
      month_urls = monthly_urls
      links = []
      month_urls.each do |url|
        html = URI.open(url.to_s).read
        doc = Nokogiri::HTML.parse(html)
        links << doc.xpath("//div[@class='p-scheduled-card p-scheduled-card--horizontal']//a").map { |f| f.attribute('href').value }
      end
      links.flatten
    end

    # イベント詳細取得
    def event_details
      events = []
      livehouse_id = Livehouse.find_by('name LIKE?', '%Spotify O-nest%').id
      links = day_links
      links.map do |link|
        link_html = URI.open(link.to_s)
        link_doc = Nokogiri::HTML.parse(link_html)
        events << { title: title(link_doc),
                    held_on: held_on(link_doc),
                    open: open(link_doc),
                    start: start(link_doc),
                    price: price(link_doc),
                    artist: artist(link_doc),
                    url: link,
                    livehouse_id: livehouse_id }
      end
      events
    end

    def title(link_doc)
      title = link_doc.xpath("//span[@class='p-schedule-detail__title-main']")
      title.text.to_s.strip.presence || '未定'
    end

    def held_on(link_doc)
      held_on = link_doc.xpath("//span[@class='p-schedule-detail__date-item']")
      if held_on.blank?
        '1000-01-01'
      else
        year = Date.current.year
        held_on.text.gsub(' / ', '-').insert(0, "#{year}-") || '1000-01-01'
      end
    end

    def open(link_doc)
      open = link_doc.xpath("//div[@class='p-schedule-detail__dd']")[0]
      if open.blank?
        '未定'
      else
        open.text
      end
    end

    def start(link_doc)
      start = link_doc.xpath("//div[@class='p-schedule-detail__dd']")[1]
      if start.blank?
        '未定'
      else
        start.text
      end
    end

    def price(link_doc)
      price = link_doc.xpath("//div[@class='p-schedule-detail__dd']")[2]
      if price.blank?
        0
      else
        price.text[/(?<=[￥¥])([0-9０−９,]{3,6})/].to_s.gsub(',', '').to_i
      end
    end

    def artist(link_doc)
      artist = link_doc.xpath("//ul[@class='p-schedule-detail__artist']")
      if artist.blank?
        '未定'
      else
        artist.text.strip.gsub(/\t| |\n|（|）/, { "\t" => '', ' ' => '', "\n" => ' / ', '（' => '(', '）' => ')' }) || '未定'
      end
    end
  end
end
