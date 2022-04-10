class OnestScraping < ApplicationRecord
  require 'open-uri'

  class << self
    def execute
      o_nest_save
    end

    private

    def o_nest_save
      date = Date.current
      livehouse_id = Livehouse.find_by('name LIKE?', '%Spotify O-nest%').id
      @events = []
      3.times do |_f|
        year = date.year
        month = date.month
        url = "https://shibuya-o.com/nest/schedule/?y=#{year}&m=#{month}/"
        o_nest_get(url, livehouse_id)
        date = date.next_month
        date = date.next_year if date.month == 1
      end
      Event.import @events, validate_uniqueness: true, on_duplicate_key_update: { constraint_name: :for_upsert, columns: %i[title held_on open start price artist] }
    end

    # "Spotify O-nest"スクレイピング、DB保存
    def o_nest_get(url, livehouse_id)
      html = URI.open(url.to_s).read
      doc = Nokogiri::HTML.parse(html)
      links = doc.xpath("//div[@class='p-scheduled-card p-scheduled-card--horizontal']//a").map { |f| f.attribute('href').value }
      links.map do |link|
        link_html = URI.open(link.to_s)
        link_doc = Nokogiri::HTML.parse(link_html)
        @events << {  title: title_get(link_doc),
                      held_on: held_on_get(link_doc),
                      open: open_get(link_doc),
                      start: start_get(link_doc),
                      price: price_get(link_doc),
                      artist: artist_get(link_doc),
                      url: link,
                      livehouse_id: livehouse_id }
      end
    end

    def title_get(link_doc)
      title = link_doc.xpath("//span[@class='p-schedule-detail__title-main']")
      if title.blank?
        '未定'
      else
        title.text.to_s.strip || '未定'
      end
    end

    def held_on_get(link_doc)
      held_on = link_doc.xpath("//span[@class='p-schedule-detail__date-item']")
      if held_on.blank?
        '1000-01-01'
      else
        year = Date.current.year
        held_on.text.gsub(' / ', '-').insert(0, "#{year}-") || '1000-01-01'
      end
    end

    def open_get(link_doc)
      open = link_doc.xpath("//div[@class='p-schedule-detail__dd']")[0]
      if open.blank?
        '未定'
      else
        open.text
      end
    end

    def start_get(link_doc)
      start = link_doc.xpath("//div[@class='p-schedule-detail__dd']")[1]
      if start.blank?
        '未定'
      else
        start.text
      end
    end

    def price_get(link_doc)
      price = link_doc.xpath("//div[@class='p-schedule-detail__dd']")[2]
      if price.blank?
        0
      else
        price.text[/(?<=[￥¥])([0-9０−９,]{3,6})/].to_s.gsub(',', '').to_i
      end
    end

    def artist_get(link_doc)
      artist = link_doc.xpath("//ul[@class='p-schedule-detail__artist']")
      if artist.blank?
        '未定'
      else
        artist.text.strip.gsub(/\t| |\n|（|）/, { "\t" => '', ' ' => '', "\n" => ' / ', '（' => '(', '）' => ')' }) || '未定'
      end
    end
  end
end
