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
    Interface.category_list
    puts "Choose a category by typing it's name"
    loop do
      puts "If you would like to #{Interface.print_red("exit")}, type 'exit'"
      conditional
    end
  end

  def conditional
    input = gets.strip.downcase
    exit_program if input == "exit"

    category = Category.find_by_name(input)
    if category
      info(category)
    elsif
      Interface.category_error
    end
  end

  def exit_program
    puts "Thanks for browsing, see you later!".colorize(:light_blue)
    exit
  end

  def info(category)
    @scraper.scrape_category(category) unless category.scraped
    first_section(category)
    puts ""
    puts "If you'd like to look at a different category, " \
         "type in a different name."
    Interface.category_list
  end

  def first_section(category)
    puts ""
    puts "You have chosen '#{Interface.print_blue(category.name)}'"
    puts "We recommend checking out one of the featured articles:"
    list_of_features(category)
    Interface.id_more_cat
    category_conditional(category)
  end

  def list_of_features(category)
    Article.featured_for_category(category).map do |feature|
      puts "* Feature ID: #{feature.id}"
      puts "* #{feature.title}"
      puts "*~~*~~*~~*~~*~~*~~*~~*~~*".colorize(:light_blue)
    end
  end

  def category_conditional(category)
    input = gets.strip.downcase
    if input == "more" then more_clause(category)
    elsif input == "categories" then start
    elsif Article.featured_for_category(category)
                 .include?(Article.find_by_id(input.to_i))
      feature_select(input)
    else
      feature_error(category)
    end
  end

  def more_clause(category)
    puts ""
    puts "Here are some more articles about" \
    " #{Interface.print_blue(category.name)}:"
    list_of_other_articles(category)
    Interface.yes_no
    extra_article_condition
  end

  def feature_select(input)
    feat = Article.find_by_id(input.to_i)
    @scraper.scrape_article(feat)
    puts "You chose #{Interface.print_blue(feat.title)}," \
      " which was written by #{feat.author}."
    puts "A glimpse into this feature article:"
    puts "    #{feat.biopart2}"
    puts "Here's the link to read more: #{feat.link}"
  end

  def feature_error(category)
    Interface.wrong_feature
    category_conditional(category)
  end

  def list_of_other_articles(category)
    Article.more_articles_for_category(category).map do |article|
      puts "* Article ID: #{article.id}"
      puts "* Title: #{article.title}"
      puts "*~~*~~*~~*~~*~~*~~*~~*~~*".colorize(:light_blue)
    end
  end

  def extra_article_condition
    input = gets.strip.downcase
    if input != "yes" && input != "no"
      puts "#{Interface.red_sorry} I don't understand your command," \
        " please try typing in 'yes' or 'no'."
      extra_article_condition
    elsif input == "yes"
      yes_condition
    elsif input == "no"
      start
    end
  end

  def yes_condition
    Interface.yes_ask
    input = gets.strip.to_i
    if input <= 0 || !Article.find_by_id(input)
      Interface.wrong_article
    else
      article = Article.find_by_id(input)
      print "Here's the link to"
      print " '#{article.title}':".colorize(:light_blue)
      puts " #{article.link}"
    end
  end
end
