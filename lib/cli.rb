require "pry"
# responsible for communication with the user
# puts a lot
# invokes scraper class
# not using noku (for scraping)

class Cli
  def call
    Scraper.new
    print "*~~*~~*".colorize(:light_blue)
    print " Welcome fashionista/fashionisto! ".colorize(:light_blue).underline
    puts "*~~*~~*".colorize(:light_blue)
    print "Here you can stay up to date".colorize(:light_blue)
    puts " with all the latest fashion trends.".colorize(:light_blue)
    start
  end

  def start
    list
    print "Choose an article by entering the article ID number"
    puts " it is associated with."
    loop do
      print "If you would like to"
      print " exit".colorize(:red)
      puts ", type 'exit'"
      conditional
    end
  end

  def list
    puts ""
    puts "Current Articles to Explore:".colorize(:light_blue).underline
    list_art
  end

  def list_art
    Article.all.map do |art|
      puts "* Article ID: #{art.id}"
      puts "* Title: #{art.title}"
      puts "* Author: #{art.author}"
      print "*~~*~~*~~*~~*~~*~~*~~*".colorize(:light_blue)
      puts "~~*~~*~~*~~*~~*~~*~~*~~*".colorize(:light_blue)
    end
  end

  def conditional
    input = gets.strip.downcase
    if input == "exit"
      ex
    elsif input.to_i <= 0 || input.to_i > Article.all.count
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
    print " there is currently no article associated with that ID,"
    puts " try entering a different ID:".colorize(:red)
  end

  def info(input)
    article = Article.find_by_id(input.to_i)
    Scraper.new.scrape_article(article)
    info_layout(article)
  end

  def info_layout(article)
    first_sec(article)
    second_sec(article)
    print "If you'd like to look at a different article,"
    puts " enter that article's ID number."
  end

  def first_sec(article)
    print "You have chosen".colorize(:light_blue)
    print " '#{article.title}'"
    print ", written on".colorize(:light_blue)
    puts " #{article.date}."
    puts ""
  end

  def second_sec(article)
    print "To give you an idea of what this article is about,"
    print " here is an"
    puts " abstract:".colorize(:light_blue)
    puts "    #{article.biopart1}"
    puts "    #{article.biopart2}"
    print "If interested in the full article, visit:".colorize(:light_blue)
    puts " #{article.url}"
    puts ""
  end
end
