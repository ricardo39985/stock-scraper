require_relative 'environment.rb'

class RunScrape
  def self.main
    input = nil
    puts"Welcome to my Scraper!\nIt scrapes stock data and provides access to the latest news"
    while input != 'exit'
      puts "To get a list of company press 1\nTo search for  a company by symbol press 2"
      input = gets.chomp
      case input
      when '1'
        stocks.each { |hash| puts e.company }
      end

    end

  end

  def self.stocks
    Stock.import(Scraper.new.import)
  end
  def method_name

  end

end
