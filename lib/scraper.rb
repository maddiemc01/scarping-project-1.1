require "pry"
# no "puts"
class Scraper
  BASE_URL = "https://www.vogue.com"

  def initialize
    main_page = Nokogiri::HTML(HTTParty.get("https://www.vogue.com/fashion").body)
    main_page.css(".channel-nav--link")[1..-1].each do |category|
      name = category.text
      url = BASE_URL + category.attr("href")
      Category.new(name, url)
    end
  end
    # scrapes all the articles under category instance
  # def scrape_category(category)
  #   page = Nokogiri::HTML(HTTParty.get(category.url).body)
  #   category.articles = all_articles(page)
  #     binding.pry
  # end

  # def all_articles(page)
  #   page.css(".feed-card").each do |artinfo|
  #     title = artinfo.css(" .feed-card--title a").text
  #     author = artinfo.css(".contributor-byline--name").text
  #     link = artinfo.css(" .feed-card--title a").attr("href").text
  #     Article.new(title, author, link)
  #   end
  # end
  # # # scrapes each instacnce of article bio/ info
  # def scrape_article(article)
  #   article_page = Nokogiri::HTML(HTTParty.get(article.link).body)
  #   article.biopart1 = article_page.css("p")[2].text
  #   article.biopart2 = article_page.css("p")[3].text
  #   article.date = article_page.css(".content-header__publish-date").text
  # end
end
