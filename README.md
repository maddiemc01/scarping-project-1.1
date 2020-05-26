# scarping-project-1.1

##Objectives

1. Use Nokogiri to scrape diffferent fashion categories
2. Create a CLI so the user can see that list of categories
3. Use nokigiri to also scrape articles under the scraped categories
4. Give user the option to select one of the articles and get more information (scraped)
4. User can click on the link assocaited with the article to open the web page for the full article, or look at more categories/ articles

##Overview

  This app will scrape the different categories under the Vogues fashion webpage. When the CLI starts, it will welcome the user (fashionista/fashionisto), and provide the different categories to choose from. Once a category is chosen, there is a list of "featured" articles (which were scraped differently from "other" articles). If the user selects a featured article (by ID) they will be reminded of the title, and provided info that was scarped form that specfic article (when it was written and an extract of the article) and the link to the full article. If the user is not interested in a featured article, they can see a list of other articles (selected by ID) and given that link or go back to categories.

##Navigation

1. Start the program by typing in 'ruby bin/run.rb' into the terminal
2. The program will begin by listing the categories; you select the one you want by typing in the category
3. It will list 4 featured articles with IDs. You can type in an ID number to select one, or type in 'more' to see 8 more articles, or 'categories' to go back to the list of categories
3. For the a featured article you chose, you will be provided the article's title, the author, when it was written, an extract from the article, and a link to the whole article.
4. For 'more' it will give you the list of other articles. If you are interersted in one, type yes, and it will prompt you to type in the article ID to provide you the date and the link to read the full article.
5. For 'categories', or if you wanted more, but the other articles don't interest you and you type 'no', the program will take you back to the list of categories to choose from and will also give you the option to 'exit'.