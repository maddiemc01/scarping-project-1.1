# responsible for communication with the user
# puts a lot
# invokes scraper class
# not using noku (for scraping)

class Cli
  def call
    @scraper = Scraper.new
    Interface.welcome
    start
  end

  def start
    Interface.cat_list
    puts "Choose a category by typing it's name"
    loop do
      print "If you would like to"
      print " exit".colorize(:red)
      puts ", type 'exit'"
      conditional
    end
  end

  def conditional
    input = gets.strip.downcase
    if input == "exit"
      ex
    elsif !Category.find_by_name(input)
      Interface.cat_error
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

  def info(input)
    categ = Category.find_by_name(input)
    @scraper.scrape_category(categ)
    first_sec(categ)
    puts ""
    print "If you'd like to look at a different category,"
    puts " type in a different name."
    Interface.cat_list
  end

  def first_sec(categ)
    puts ""
    print "You have chosen"
    puts " '#{categ.name}'".colorize(:light_blue)
    puts "We recommend checking out one of the featured articles:"
    list_of_feat(categ)
    Interface.id_more_cat
    cat_conditional(categ)
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
      puts ""
      print "Here are some more articles about"
      puts " #{categ.name}:".colorize(:light_blue)
      list_of_otherart
      Interface.yes_no
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
      @scraper.scrape_article(feat)
      print "You chose"
      print " '#{feat.title}'".colorize(:light_blue)
      puts ", which was written by #{feat.author}."
      puts "This feature starts off with:"
      puts "    #{feat.biopart1}"
      puts "Here's the link to read more: #{feat.link}"
  end

  def feat_error(categ)
    Interface.wrong_feat
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
      print "Sorry,".colorize(:red)
      puts " I don't understand your command, please try typing in 'yes' or 'no'."
      extra_art_condition
    elsif input == "yes"
      print "Which article were you interested in? Select it by"
      print " article ID".colorize(:light_blue)
      puts " number:"
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
      print "Here's the link to"
      print " '#{article.title}':".colorize(:light_blue)
      puts " #{article.link}"
    end
  end

end
