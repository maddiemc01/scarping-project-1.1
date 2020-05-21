class Scraper
  BASE_URL = "https://www.vogue.com".freeze

  def initialize
    main_page = Nokogiri::HTML(HTTParty
                .get("https://www.vogue.com/fashion").body)
    main_page.css(".channel-nav--link")[1..-1].each do |category|
      name = category.text
      url = BASE_URL + category.attr("href")
      Category.new(name, url)
    end
  end

  # scrapes all the articles under category instance
  def scrape_category(category)
    return if category.scraped

    page = Nokogiri::HTML(HTTParty.get(category.url).body)
    featurearts(page, category)
    otherarts(page, category)
    category.scraped = true
  end

  def featurearts(page, category)
    page.css(".four-story--item").each do |info|
      title = info.css(".four-story--title a").text
      link = info.css(".four-story--title a").attr("href").text
      Article.new(title, link, category, true)
    end
  end

  def scrape_article(article)
    article_page = Nokogiri::HTML(HTTParty.get(article.link).body)
    article.author = article_page.css(".byline__name").text
    article.biopart1 = article_page.css("p")[2].text
    article.biopart2 = article_page.css("p")[3].text
    article.date = article_page.css(".content-header__publish-date").text
  end

  def otherarts(page, category)
    page.css(".feed-card").each do |info|
      title = info.css(".feed-card--title a").text
      link = info.css(".feed-card--title a").attr("href").text
      Article.new(title, link, category, false)
    end
  end
end
