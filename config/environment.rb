require "pry"
require "nokogiri"
require "open-uri"
class Scraper
  def initialize
    url = open('https://www.marketwatch.com/tools/stockresearch/screener/results.asp?TradesShareEnable=False&PriceDirEnable=False&PriceDir=Up&LastYearEnable=False&TradeVolEnable=False&BlockEnable=False&PERatioEnable=False&MktCapEnable=False&MovAvgEnable=False&MovAvgType=Outperform&MovAvgTime=FiftyDay&MktIdxEnable=False&MktIdxType=Outperform&Exchange=All&IndustryEnable=False&Industry=Accounting&Symbol=True&CompanyName=True&Price=True&Change=True&ChangePct=True&Volume=True&LastTradeTime=False&FiftyTwoWeekHigh=False&FiftyTwoWeekLow=False&PERatio=False&MarketCap=False&MoreInfo=True&SortyBy=Symbol&SortDirection=Ascending&ResultsPerPage=TwentyFive&PagingIndex=0')

    doc = Nokogiri::HTML(url)
    listings = doc.css("tbody tr")
    stocks = []

    listings.each do |stock|
        stock_att = {
        symbol: stock.css("td a")[0].text,
        company: stock.css(" a")[1].text,
        price: stock.css("td")[2].text,
        volume: stock.css("td")[5].text,
        percent_change: stock.css("td")[4].text
        }
        stocks << stock_att
    end
    binding.pry

  end

end
Scraper.new
