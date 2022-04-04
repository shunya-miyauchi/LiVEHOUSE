class Scraping < Event
  require 'open-uri'

  def program
    basementbar_save
  end
  
  def basementbar_get(url)
    html = URI.open("#{url}").read
    doc = Nokogiri::HTML.parse(html)
    
    links = doc.xpath("//h2[@class='eo-event-title entry-title']//a").map {|f| f.attribute("href").value}
    
    links.map do |link|
      # sleep 1
      link_html = URI.open("#{link}")
      link_doc = Nokogiri::HTML.parse(link_html)
      @events << {  title: link_doc.xpath("//div[@class='main_title']").text,
                    held_on: link_doc.xpath("//div[@class='date']").text[/\A[^日]+/].to_s.gsub(/年|月|日/,"-").tr('０-９','0-9'),
                    open: link_doc.xpath("//div[@class='sub_detail']").text[/(?<=OPEN)*(\d{2}:\d{2})/,1],
                    start: link_doc.xpath("//div[@class='sub_detail']").text[/(?<=START)(\d{2}:\d{2})/,1],
                    price: link_doc.xpath("//div[@class='sub_detail']").text[/[￥¥](.*?)-/,1].to_s.gsub(",","").to_i,
                    artist: link_doc.xpath("//div[@class='detail']").text.gsub(/\n|\r|\r\n/, " / "),
                    livehouse_id: 1
      }
    end
  end

  def basementbar_save
    date = Date.current
    @events = []
    3.times do |f|
      year = date.year
      month = date.strftime("%m")
      url = "https://toos.co.jp/basementbar/event/on/#{year}/#{month}/"
      basementbar_get(url)
      date = date.next_month
      date = date.next_year if date.month == 1
    end
    Event.where(livehouse_id: 1).destroy_all
    Event.import @events
  end

  

end