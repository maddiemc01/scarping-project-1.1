# responsible for communication with the user
# puts a lot
# invokes scraper class
# not using noku (for scraping)
require_relative "./color.rb"

class Cli
  include Color
  def call
    @scraper = Scraper.new
    Interface.scraper = @scraper
    Interface.welcome
    start
  end

  def start
    Interface.category_list
    puts "Choose a category by typing it's name"
    loop do
      puts "If you would like to #{print_red('exit')}, type 'exit'"
      category_conditional
    end
  end

  def category_conditional
    input = gets.strip.downcase
    exit_program if input == "exit"
    category = Category.find_by_name(input)
    category ? category_info(category) : Interface.category_error
  end

  def exit_program
    puts "Thanks for browsing, see you later!".colorize(:light_blue)
    exit
  end

  def category_info(category)
    @scraper.scrape_category(category) unless category.scraped
    category_section(category)
    puts "\nIf you'd like to look at another category, " \
         "type in another category."
    Interface.category_list
  end

  def category_section(category)
    puts "\nYou have chosen '#{print_blue(category.name)}'"
    puts "We recommend checking out one of the featured articles:\n\n"
    Interface.list_of_features(category)
    Interface.give_options_id_more_or_category
    feature_conditional(category)
  end

  def feature_conditional(category)
    input = gets.strip.downcase
    if input == "more" then more_clause(category)
    elsif input == "categories" then start
    elsif Article.featured_for_category(category)
                 .include?(Article.find_by_id(input.to_i))
      feature_select(input)
    else
      feature_error
      feature_conditional(category)
    end
  end

  def more_clause(category)
    puts "\nHere are some more articles about" \
    " #{print_blue(category.name)}:\n\n"
    Interface.list_of_other_articles(category)
    Interface.ask_yes_no
    extra_article_condition(category)
  end

  def feature_select(input)
    feature = Article.find_by_id(input.to_i)
    @scraper.scrape_article(feature)
    puts "\nYou chose #{print_blue(feature.title)}," \
      " which was written by #{feature.author} on #{feature.date}."
    puts "A glimpse into this feature article:"
    puts "    #{feature.bio}"
    puts "Here's the link to read more: #{feature.link}"
  end

  def feature_error
    Interface.wrong_feature
  end

  def extra_article_condition(category)
    input = gets.strip.downcase
    if input != "yes" && input != "no"
      puts "#{Interface.red_sorry} I don't understand your command," \
        " please try typing in 'yes' or 'no'."
      extra_article_condition(category)
    elsif input == "yes" then yes_clause(category)
    elsif input == "no" then start
    end
  end

  def yes_clause(category)
    Interface.ask_after_yes
    input = gets.strip.to_i
    if Article.more_articles_for_category(category)
              .include?(Article.find_by_id(input.to_i))
      Interface.article_info(input)
    else
      Interface.wrong_article
      yes_clause(category)
    end
  end
end
