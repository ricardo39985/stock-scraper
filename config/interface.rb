require_relative 'environment.rb'

class RunScrape
  def initialize
    stocks
    welcome
    main
    exit_m

  end
  def welcome
    puts `clear`
    puts "(  ____ \\__   __/(  ___  )(  ____ \| \    /\     (  ____ \(  ____ \(  ____ )(  ___  )(  ____ )(  ____ \(  ____ )
| (    \/   ) (   | (   ) || (    \/|  \  / /     | (    \/| (    \/| (    )|| (   ) || (    )|| (    \/| (    )|
| (_____    | |   | |   | || |      |  (_/ /_____ | (_____ | |      | (____)|| (___) || (____)|| (__    | (____)|
(_____  )   | |   | |   | || |      |   _ ((_____)(_____  )| |      |     __)|  ___  ||  _____)|  __)   |     __)
      ) |   | |   | |   | || |      |  ( \ \            ) || |      | (\ (   | (   ) || (      | (      | (\ (
/\____) |   | |   | (___) || (____/\|  /  \ \     /\____) || (____/\| ) \ \__| )   ( || )      | (____/\| ) \ \__
\_______)   )_(   (_______)(_______/|_/    \/     \_______)(_______/|/   \__/|/     \||/       (_______/|/   \__/
                                                                                                                 "
    puts"Welcome to my Scraper!\nIt scrapes stock data and provides access to the latest news"
    intro_timer
    puts `clear`
  end
  def main
    input = nil
    while input != 'exit'
      puts "**************************************\n*Below is a list of available commands \n***************************************\n"
      puts "1- List of Companies\n2. Search\n3. Sort\n4. View Random Stock"
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
      when '4'
        rand_stock
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
    puts `clear`
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
  def rand_stock
    puts `clear`
    match = Stock.all[rand(24)]
    puts "Company   "+match.company, "Ticker   "+match.symbol, "Price   "+match.price, "Volume   "+match.volume, "Percent Change   "+match.percent_change, "News  "+match.news
  end
  def intro_timer(timer = 12)
    s = "|"
    timer.downto(0) do |i|
      colors = String.colors
      print s
      s+="|".colorize(colors[rand(16)])
      sleep 0.2
    end
  end
  def exit_m
    puts "Thanks for checking out my work.\nI welcome your feedback!"
    intro_timer(30)
  end

end
