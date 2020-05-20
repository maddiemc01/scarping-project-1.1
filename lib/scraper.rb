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
  def scrape_category(categ)
    page = Nokogiri::HTML(HTTParty.get(categ.url).body)
    categ.featart = featurearts(page)
    categ.otherart = otherarts(page)
  end

  end

  def featurearts(page)
    page.css(".four-story--item").each do |info|
      title = info.css(".four-story--title a").text
      link = info.css(".four-story--title a").attr("href").text
      FeatureArt.new(title, link)
  end

  def scrape_feat(article)
    #   article_page = Nokogiri::HTML(HTTParty.get(article.link).body)
    #   article.author = article_page.css("xxx").text
    #   article.biopart1 = article_page.css("p")[2].text
    #   article.biopart2 = article_page.css("p")[3].text
    #   article.date = article_page.css(".content-header__publish-date").text
    # end

  def otherarts(page)
    page.css(".feed-card").each do |info|
      title = info.css(" .feed-card--title a").text
      link = info.css(" .feed-card--title a").attr("href").text
      Article.new(title, link)
    end
  end

  # # # scrapes each instacnce of article bio/ info
  # def scrape_other(article)
  #   article_page = Nokogiri::HTML(HTTParty.get(article.link).body)
  #   article.author = article_page.css("xxx").text
  #   article.biopart1 = article_page.css("p")[2].text
  #   article.biopart2 = article_page.css("p")[3].text
  #   article.date = article_page.css(".content-header__publish-date").text
  # end
end
