require "pry"
# responsible for communication with the user
# puts a lot
# invokes scraper class
# not using noku (for scraping)

class Cli
  def call
    @scraper = Scraper.new
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
    list_of_cat
  end

  def list_of_cat
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
      cat_error
    elsif input
      FeatureArt.all.clear
      Article.all.clear
      info(input)
    end
  end

  def ex
    puts "Thanks for browsing, see you later!".colorize(:light_blue)
    exit
  end

  def cat_error
    print "Sorry,".colorize(:red)
    print " there is currently no additional info on that category,"
    puts " try entering a different category name:".colorize(:red)
  end

  def info(input)
    categ = Category.find_by_name(input)
    @nestedscrape = @scraper.scrape_category(categ)
    info_layout(categ)
  end

  def info_layout(categ)
    first_sec(categ)
    print "If you'd like to look at a different category,"
    puts " type in a different name."
    cat_list
  end

  def first_sec(categ)
    print "You have chosen".colorize(:light_blue)
    puts " '#{categ.name}'"
    puts "We recommend checking out one of the featured articles:"
    list_of_feat(categ)
    puts "Select one of the feature articles by entering it's feature ID number to access more info"
    puts "If none of these articles interest, you can be provided with more articles by typing in 'more' or go back to categories by typing 'categories'."
    cat_conditional(categ)
    # puts "#{categ.otherart}"
  end

  def list_of_feat(categ)
    FeatureArt.all.map do |feat|
      puts "* Feature ID: #{feat.id}"
      puts "* #{feat.title}"
      puts "*~~*~~*~~*~~*~~*~~*~~*~~*".colorize(:light_blue)
    end
  end

  def cat_conditional(categ)
    input = gets.strip.downcase
    if input == "more"
      puts "Here are some more articles about #{categ.name}:"
      list_of_otherart
      puts "Do any of these interest you?"
      puts "Type 'yes' and we can provide you the link to full article or type 'no' and we will take you back to all categories"
      extra_art_condition
    elsif input == "categories"
      FeatureArt.all.clear
      Article.all.clear
      start
    elsif input.to_i > 0 && input.to_i <= FeatureArt.all.count
      feat_select(input)
    else
      feat_error(categ)
    end
  end

  def feat_select(input)
      feat = FeatureArt.find_by_id(input.to_i)
      @nestedscrape.scrape_feat(feat)
      puts "You chose '#{feat.title}', which was written by #{feat.author}."
      puts "Here's the link: #{feat.link}"
  end

  def feat_error(categ)
    print "Sorry,".colorize(:red)
    print " there are no articles for that feature article,"
    puts " try entering a different feature ID:".colorize(:red)
    puts ""
    cat_conditional(categ)
  end

  def list_of_otherart
    Article.all.map do |art|
      puts "* Article ID: #{art.id}"
      puts "* Title: #{art.title}"
      puts "*~~*~~*~~*~~*~~*~~*~~*~~*".colorize(:light_blue)
    end
  end

  def extra_art_condition
    input = gets.strip.downcase
    if input != "yes" && input != "no"
      puts "Sorry, I don't understand your command, please try typing in 'yes' or 'no'."
      extra_art_condition
    elsif input == "yes"
      puts "Which article were you intereested in? Select it by article ID num:"
      yes_condition
    elsif input == "no"
      FeatureArt.all.clear
      Article.all.clear
      start
    end
  end

  def yes_condition
    input = gets.strip
    if input.to_i <= 0 || input.to_i > Article.all.count
      puts "Sorry, there's no link associated with that article, try a different article number:"
      yes_condition
    else
      article = Article.find_by_id(input.to_i)
      puts "Here's the link: #{article.link}"
    end
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
