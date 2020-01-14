require "pry"
require "nokogiri"
require "open-uri"
require_relative 'url.rb'

class Scraper
  def initialize
    url = open(Url.main+"0")
    doc = Nokogiri::HTML(url)

    page_counter = 0
    stocks_per_page = doc.css("tbody tr").size.to_f
    total_stocks = doc.css(".pager div")[0].text.split(" ")[-2].to_f #Extracted a total count of all stocks to float format
    final_page = (total_stocks/stocks_per_page).round
    stocks = []
    while page_counter <=final_page #Goes through each page on the site
      current_page = open(Url.main+"#{page_counter}") #changes the url on each iteration to up the site page count
      parsed = Nokogiri::HTML(current_page)
      parsed.css("tbody tr").each do |stock| # Assigns the attribute for each listing on the page in a hash. Each pass of this
        stock_att = {                      #will create one complete stock hash which will be added to the stocks array
          symbol: stock.css("td a")[0].text,
          company: stock.css(" a")[1].text,
          price: stock.css("td")[2].text,
          volume: stock.css("td")[5].text,
          percent_change: stock.css("td")[4].text,
          news: Url.news+stock.css("a")[3].attribute("href").value
          }
          stocks << stock_att
          page_counter+=1
        end
    end

  end

end
Scraper.new
