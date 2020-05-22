class Interface
  class << self
    include Color
    attr_accessor :scraper

    def welcome
      welcome_string = "Welcome fashionista/fashionisto!".underline
      puts print_blue("*~~*~~* '#{welcome_string}' *~~*~~*")
      puts print_blue("Here you can stay up to date" \
        "with all the latest fashion")
    end

    def red_sorry
      print "Sorry,".colorize(:red)
    end

    def category_error
      puts "#{red_sorry} there is currently no additional info on that" \
        " category, #{print_red('try entering a different category name:')}"
    end

    def category_list
      puts "\n#{print_blue('Categories:')}\n".underline
      Category.all.map do |cat|
        puts "* #{cat.name}"
        puts "*~~*~~*~~*~~*~~*~~*~~*~~*".colorize(:light_blue)
      end
    end

    def list_of_features(category)
      Article.featured_for_category(category).map do |feature|
        puts "* Feature ID: #{feature.id}"
        puts "* #{feature.title}"
        puts "*~~*~~*~~*~~*~~*~~*~~*~~*".colorize(:light_blue)
      end
    end

    def give_options_id_more_or_category
      puts "Select one of the feature articles by entering" \
        " it's #{print_blue('feature ID')} number to access more info."
      puts "If none of these articles interest you," \
        " you can be provided with more articles by typing in " \
        "#{print_pink("'more'")} or go back to categories " \
        "by typing #{print_pink("'categories'")}"
    end

    def list_of_other_articles(category)
      Article.more_articles_for_category(category).map do |article|
        puts "* Article ID: #{article.id}"
        puts "* Title: #{article.title}"
        puts "*~~*~~*~~*~~*~~*~~*~~*~~*".colorize(:light_blue)
      end
    end

    def ask_yes_no
      puts "Do any of these interest you?"
      puts "Type #{print_green("'yes'")} and we can provide you the link to " \
        "the full article or type #{print_red("'no'")} " \
        "and we will take you back to all categories."
    end

    def wrong_feature
      puts "#{red_sorry} that command was not understood, try entering a " \
        "#{print_red('valid')} feature ID number, or " \
        "#{print_red('check your spelling')} and type 'more'" \
          " or 'categories'\n\n"
    end

    def ask_after_yes
      puts "Which article were you interested in? Select it by " \
        "#{print_blue('article ID')} number:"
    end

    def wrong_article
      puts "#{red_sorry} there's no link associated with that article," \
      " try a different article number:"
    end

    def article_info(input)
      article = Article.find_by_id(input)
      scraper.scrape_article(article)
      puts "\nGreat choice, and seems fairly recent since" \
        " it was written on #{article.date}."
      puts "Here's the link to " \
        "'#{Interface.print_blue(article.title)}':#{article.link}"
    end
  end
end
