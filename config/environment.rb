require "pry"
require "nokogiri"
require "open-uri"
require_relative 'url.rb'

class Scraper
  def initialize
    url = open(Url.main+"0")
    doc = Nokogiri::HTML(url)
    listings = doc.css("tbody tr")
    stocks = []
    page_counter = 0
    per_page = listings.size.to_f
    total_stocks = doc.css(".pager div")[0].text.split(" ")[-2].to_f
    final_page = (total_stocks/per_page).round
    while page_counter <=final_page
      current_page = open(Url.main+"#{page_counter}")
      parsed = Nokogiri::HTML(current_page)
      parsed.css("tbody tr").each do |stock|
          stock_att = {
          symbol: stock.css("td a")[0].text,
          company: stock.css(" a")[1].text,
          price: stock.css("td")[2].text,
          volume: stock.css("td")[5].text,
          percent_change: stock.css("td")[4].text,
          news: Url.news+stock.css("a")[3].attribute("href").value
          }
          stocks << stock_att
          page_counter+=1
          binding.pry

        end
    end

  end

end
Scraper.new
