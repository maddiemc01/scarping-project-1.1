require "pry"
# responsible for communication with the user
# puts a lot
# invokes scraper class
# not using noku (for scraping)

class Cli
  def call
    Scraper.new
    welcome
    start
  end

  def welcome
    print "*~~*~~*".colorize(:light_blue)
    print " Welcome fashionista/fashionisto! ".colorize(:light_blue).underline
    puts "*~~*~~*".colorize(:light_blue)
    print "Here you can stay up to date".colorize(:light_blue)
    puts " with all the latest fashion".colorize(:light_blue)
  end

  def start
    cat_list
    puts "Choose a category by typing it's name"
    loop do
      print "If you would like to"
      print " exit".colorize(:red)
      puts ", type 'exit'"
      conditional
    end
  end

  def cat_list
    puts ""
    puts "Categories:".colorize(:light_blue).underline
    list_all
  end

  def list_all
    Category.all.map do |cat|
      puts "* #{cat.name}"
      puts "*~~*~~*~~*~~*~~*~~*~~*~~*".colorize(:light_blue)
    end
  end

  def conditional
    input = gets.strip.downcase
    if input == "exit"
      ex

    elsif !Category.find_by_name(input)
      error
    elsif input
      info(input)
    end
  end

  def ex
    puts "Thanks for browsing, see you later!".colorize(:light_blue)
    exit
  end

  def error
    print "Sorry,".colorize(:red)
    print " there is currently no additional info on that category,"
    puts " try entering a different category name:".colorize(:red)
  end

  def info(input)
    categ = Category.find_by_name(input)
    Scraper.new.scrape_category(categ)
    info_layout(categ)
  end

  def info_layout(categ)
    first_sec(categ)
    print "If you'd like to look at a different category,"
    puts " type in a different name."
  end

  def first_sec(categ)
    print "You have chosen".colorize(:light_blue)
    puts " '#{categ.name}'"
    puts "we recommend checking out one of the featured articles:"
    #scrape top articles
    puts "or if none of those interest you, here's a list of other articles to keep you up to date with the lastest #{categ.name}."
  end

  # def second_sec(article)
  #   print "To give you an idea of what this article is about,"
  #   print " here is an"
  #   puts " abstract:".colorize(:light_blue)
  #   puts "    #{article.biopart1}"
  #   puts "    #{article.biopart2}"
  #   print "If interested in the full article, visit:".colorize(:light_blue)
  #   puts " #{article.url}"
  #   puts ""
  # end
end
