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

    def category_error
      print("Sorry,".colorize(:red))
      print " there is currently no additional info on that category,"
      puts " try entering a different category name:".colorize(:red)
    end

    def category_list
      puts ""
      puts "Categories:".colorize(:light_blue).underline
      Category.all.map do |cat|
        puts "* #{cat.name}"
        puts "*~~*~~*~~*~~*~~*~~*~~*~~*".colorize(:light_blue)
      end
    end

    def id_more_cat
      print "Select one of the feature articles by entering it's"
      print " feature ID".colorize(:light_blue)
      puts " number to access more info."
      print "If none of these articles interest you, "
      print "you can be provided with more articles by typing in"
      print " 'more'".colorize(:magenta)
      print " or go back to categories by typing "
      puts "'categories'.".colorize(:magenta)
    end

    def yes_no
      puts "Do any of these interest you?"
      print "Type"
      print " 'yes'".colorize(:green)
      print " and we can provide you the link to full article or type"
      print " 'no'".colorize(:red)
      puts " and we will take you back to all categories."
    end

    def wrong_feat
      print "Sorry,".colorize(:red)
      print " that command was not understood,"
      print " try entering a"
      print " valid".colorize(:red)
      print " feature ID number, or"
      print " check your spelling".colorize(:red)
      puts " and type 'more' or 'categories'"
      puts ""
    end
  end
end
