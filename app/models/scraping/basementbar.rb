class Scraping::Basementbar < ApplicationRecord
  require 'open-uri'

  class << self
    def execute
      basementbar_import
    end

    def import()

    private

    def basementbar_import
      date = Date.current
      livehouse_id = Livehouse.find_by('name LIKE?', '%下北沢BASEMENT BAR%').id
      @events = []
      3.times do |_f|
        year = date.year
        month = date.strftime('%m')
        url = "https://toos.co.jp/basementbar/event/on/#{year}/#{month}/"
        events_get(url, livehouse_id)
        date = date.next_month
        date = date.next_year if date.month == 1
      end
      Event.import @events,
                   validate_uniqueness: true,
                   on_duplicate_key_update: {
                     constraint_name: :for_upsert,
                     columns: %i[title held_on open start price artist]
                   }
    end

    def events_get(url, livehouse_id)
      html = URI.open(url.to_s).read
      doc = Nokogiri::HTML.parse(html)
      links = doc.xpath("//h2[@class='eo-event-title entry-title']//a").map { |f| f.attribute('href').value }
      links.map do |link|
        link_html = URI.open(link.to_s)
        link_doc = Nokogiri::HTML.parse(link_html)
        @events << {  title: title(link_doc),
                      held_on: held_on(link_doc),
                      open: open(link_doc),
                      start: start(link_doc),
                      price: price(link_doc),
                      artist: artist(link_doc),
                      url: link,
                      livehouse_id: livehouse_id }
      end
    end

    def title(link_doc)
      title = link_doc.xpath("//div[@class='main_title']")
      title.text.presence || '未定'
    end

    def held_on(link_doc)
      held_on = link_doc.xpath("//div[@class='date']").text[/\A[^日]+/]
      if held_on.blank?
        '1000-01-01'
      else
        held_on.to_s.gsub(/年|月|日/, '-').tr('０-９', '0-9') || '1000-01-01'
      end
    end

    def open(link_doc)
      open = link_doc.xpath("//div[@class='sub_detail']")
      if open.blank?
        '未定'
      else
        open.text[/(?<=OPEN)*(\d{2}:\d{2})/, 1] || '未定'
      end
    end

    def start(link_doc)
      start = link_doc.xpath("//div[@class='sub_detail']")
      if start.blank?
        '未定'
      else
        start.text[/(?<=START)(\d{2}:\d{2})/, 1] || '未定'
      end
    end

    def price(link_doc)
      price = link_doc.xpath("//div[@class='sub_detail']")
      if price.blank?
        0
      else
        price.text[/[￥¥](.*?)-/, 1].to_s.gsub(',', '').to_i || 0
      end
    end

    def artist(link_doc)
      artist = link_doc.xpath("//div[@class='detail']")
      if artist.blank?
        '未定'
      else
        artist.text.gsub(/\n|\r|\r\n/, ' / ') || '未定'
      end
    end
  end
end
