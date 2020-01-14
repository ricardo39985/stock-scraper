require "pry"
require "nokogiri"
require "open-uri"
class Scraper
  def initialize
    html = 'https://www.marketwatch.com/tools/stockresearch/screener/results.asp?TradesShareEnable=False&PriceDirEnable=False&PriceDir=Up&LastYearEnable=False&TradeVolEnable=False&BlockEnable=False&PERatioEnable=False&MktCapEnable=False&MovAvgEnable=False&MovAvgType=Outperform&MovAvgTime=FiftyDay&MktIdxEnable=False&MktIdxType=Outperform&Exchange=All&IndustryEnable=False&Industry=Accounting&Symbol=True&CompanyName=True&Price=True&Change=True&ChangePct=True&Volume=True&LastTradeTime=False&FiftyTwoWeekHigh=False&FiftyTwoWeekLow=False&PERatio=False&MarketCap=False&MoreInfo=True&SortyBy=Symbol&SortDirection=Ascending&ResultsPerPage=TwentyFive&PagingIndex='
    url = open(html+"0")
    doc = Nokogiri::HTML(url)
    listings = doc.css("tbody tr")
    stocks = []
    first_page = 0
    per_page = listings.size.to_f
    total_stocks = doc.css(".pager div")[0].text.split(" ")[-2].to_f
    final_page = (total_stocks/per_page).round
    while first_page <=final_page
      listings.each do |stock|
          stock_att = {
          symbol: stock.css("td a")[0].text,
          company: stock.css(" a")[1].text,
          price: stock.css("td")[2].text,
          volume: stock.css("td")[5].text,
          percent_change: stock.css("td")[4].text,
          news: "https://www.marketwatch.com"+stock.css("a")[3].attribute("href").value
          }
          stocks << stock_att
          first_page+=1
        end
    end
    binding.pry

  end

end
Scraper.new
