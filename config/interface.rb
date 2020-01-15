require_relative 'environment.rb'

class RunScrape
  def initialize
    stocks

  end
  def main
    puts `clear`
    input = nil
    puts"Welcome to my Scraper!\nIt scrapes stock data and provides access to the latest news"
    while input != 'exit'
      puts "To get a list of company press 1\nTo search for  a company by symbol press 2"
      input = gets.chomp
      case input
      when '1'
        puts `clear`
        list_stocks
        input= nil
      when '2'
        find_stock_by_ticker
      when '3'
        sort
      end
    end
  end

  def stocks
    Stock.import(Scraper.new.import)
    @stock = Stock.all
  end
  def list_stocks
    @stock.each { |hash| puts hash.company }
    puts "\n\n\n"
  end
  def find_stock_by_ticker(ticker="")
    puts `clear`
    puts "Please enter the ticker :"
    ticker = gets.chomp
    match = Stock.all.detect { |stock|stock.symbol == ticker.upcase  }
    if match
    puts  match.company, match.symbol, match.price, match.volume, match.percent_change, match.news
    else
      puts "Sorry, that stock was not found in the database"
    end
    input = nil
  end
  def sort
    puts "1. Sort by name\n2. Sort by price\n3. Sort by symbol\n 4 or anything else to return to previous screen"
    sort_select = gets.chomp
    case sort_select
    when '1'
      puts Stock.all.sort_by {|obj| obj.company}
    when '2'
      pp Stock.all.sort_by(&:price)
    else
     input = nil
    end

  end

end
