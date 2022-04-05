class Scraping < Event
  require 'open-uri'

  class << self

    def execute
      basementbar_save
      o_nest_save
    end

    # "Spotify O-nest"スクレイピング、DB保存
    def o_nest_get(url,livehouse_id)
      html = URI.open("#{url}").read
      doc = Nokogiri::HTML.parse(html)
      links = doc.xpath("//div[@class='p-scheduled-card p-scheduled-card--horizontal']//a").map {|f| f.attribute("href").value} 
      links.map do |link|
        link_html = URI.open("#{link}")
        link_doc = Nokogiri::HTML.parse(link_html)
        year = Date.current.year
        @events << {  title: link_doc.xpath("//span[@class='p-schedule-detail__title-main']").text.to_s.strip,
                      held_on: link_doc.xpath("//span[@class='p-schedule-detail__date-item']").text.gsub(" / ","-").insert(0,"#{year}-"),
                      open: link_doc.xpath("//div[@class='p-schedule-detail__dd']")[0].text,
                      start: link_doc.xpath("//div[@class='p-schedule-detail__dd']")[1].text,
                      price: link_doc.xpath("//div[@class='p-schedule-detail__dd']")[2].text[/(?<=[￥¥])([0-9０−９,]{3,6})/].to_s.gsub(",","").to_i,
                      artist:link_doc.xpath("//ul[@class='p-schedule-detail__artist']").text.strip.gsub(/\t| |\n|（|）/,{"\t"=>""," "=>"","\n"=>" / ","（"=>"(","）"=>")"}),
                      url: link,
                      livehouse_id: livehouse_id
        }
      end      
    end

    def o_nest_save
      date = Date.current
      livehouse_id = Livehouse.where("name LIKE?", "%Spotify O-nest%").ids
      @events = []
      3.times do |f|
        year = date.year
        month = date.month
        url = "https://shibuya-o.com/nest/schedule/?y=#{year}&m=#{month}/"
        o_nest_get(url,livehouse_id)
        date = date.next_month
        date = date.next_year if date.month == 1
      end
      Event.import @events, validate_uniqueness: true, on_duplicate_key_update:  {constraint_name: :for_upsert, columns: %i(title held_on open start price artist)}
    end

    # "下北沢BASEMENT BAR"スクレイピング、DB保存
    def basementbar_get(url,livehouse_id)
      html = URI.open("#{url}").read
      doc = Nokogiri::HTML.parse(html)
      links = doc.xpath("//h2[@class='eo-event-title entry-title']//a").map {|f| f.attribute("href").value}
      links.map do |link|
        link_html = URI.open("#{link}")
        link_doc = Nokogiri::HTML.parse(link_html)
        @events << {  title: link_doc.xpath("//div[@class='main_title']").text,
                      held_on: link_doc.xpath("//div[@class='date']").text[/\A[^日]+/].to_s.gsub(/年|月|日/,"-").tr('０-９','0-9'),
                      open: link_doc.xpath("//div[@class='sub_detail']").text[/(?<=OPEN)*(\d{2}:\d{2})/,1],
                      start: link_doc.xpath("//div[@class='sub_detail']").text[/(?<=START)(\d{2}:\d{2})/,1],
                      price: link_doc.xpath("//div[@class='sub_detail']").text[/[￥¥](.*?)-/,1].to_s.gsub(",","").to_i,
                      artist: link_doc.xpath("//div[@class='detail']").text.gsub(/\n|\r|\r\n/, " / "),
                      url: link,
                      livehouse_id: livehouse_id
        }
      end
    end

    def basementbar_save
      date = Date.current
      livehouse_id = Livehouse.where("name LIKE?", "%下北沢BASEMENT BAR%").ids
      @events = []
      3.times do |f|
        year = date.year
        month = date.strftime("%m")
        url = "https://toos.co.jp/basementbar/event/on/#{year}/#{month}/"
        basementbar_get(url,livehouse_id)
        date = date.next_month
        date = date.next_year if date.month == 1
      end
      Event.import @events, validate_uniqueness: true, on_duplicate_key_update:  {constraint_name: :for_upsert, columns: %i(title held_on open start price artist)}
    end
  end
end