require_relative 'environment.rb'

class RunScrape
  def initialize
    stocks

  end
  def main
    input = nil
    puts"Welcome to my Scraper!\nIt scrapes stock data and provides access to the latest news"
    while input != 'exit'
      puts "To get a list of company press 1\nTo search for  a company by symbol press 2"
      input = gets.chomp
      case input
      when '1'
        list_stocks
      when '2'
        puts "Please enter the ticker :"
        ticker = gets.chomp
        find_stock_by_ticker(ticker)

      end

    end

  end

  def stocks

    Stock.import(Scraper.new.import)
    @stock = Stock.all

  end
  def list_stocks
    @stock.each { |hash| puts hash.company }
    puts "\n\n\n\n\n\n\n"
  end
  def find_stock_by_ticker(ticker)
    if Stock.all.detect { |stock|stock.symbol == ticker.upcase  }
      pp Stock.all.detect { |stock|stock.symbol == ticker.upcase  }.map { |e| e }
    else
      puts "Sorry, that stock was not found in the database"
    end
  end

end
