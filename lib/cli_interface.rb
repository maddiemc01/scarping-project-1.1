class Interface
  class << self
    def welcome
      welcome_string = "Welcome fashionista/fashionisto!".underline
      puts_blue "*~~*~~* #{welcome_string} *~~*~~*"
      puts_blue "Here you can stay up to date with all the latest fashion"
    end

    def puts_blue(string)
      puts string.colorize(:light_blue)
    end

    def print_blue(string)
      string.colorize(:light_blue)
    end

    def print_red(string)
      string.colorize(:red)
    end

    def print_pink(string)
      string.colorize(:magenta)
    end

    def print_green(string)
      string.colorize(:green)
    end

    def red_sorry
      print "Sorry,".colorize(:red)
    end

    def category_error
      puts "#{red_sorry} there is currently no additional info on that" \
        " category, #{print_red('try entering a different category name:')}"
    end

    def category_list
      puts ""
      puts "Categories:".colorize(:light_blue).underline
      puts ""
      Category.all.map do |cat|
        puts "* #{cat.name}"
        puts "*~~*~~*~~*~~*~~*~~*~~*~~*".colorize(:light_blue)
      end
    end

    def id_more_cat
      puts "Select one of the feature articles by entering" \
        " it's #{print_blue('feature ID')} number to access more info."
      puts "If none of these articles interest you," \
        " you can be provided with more articles by typing in " \
        "#{print_pink("'more'")} or go back to categories " \
        "by typing #{print_pink("'categories'")}"
    end

    def yes_no
      puts "Do any of these interest you?"
      puts "Type #{print_green("'yes'")} and we can provide you the link to " \
        "the full article or type #{print_red("'no'")} " \
        "and we will take you back to all categories."
    end

    def wrong_feature
      puts "#{red_sorry} that command was not understood, try entering a " \
        "#{print_red('valid')} feature ID number, or " \
        "#{print_red('check your spelling')} and type 'more' or 'categories'"
      puts ""
    end

    def yes_ask
      puts "Which article were you interested in? Select it by " \
        "#{print_blue('article ID')} number:"
    end

    def wrong_article
      puts "#{red_sorry} there's no link associated with that article," \
      " try a different article number:"
      yes_condition
    end

  end
end
