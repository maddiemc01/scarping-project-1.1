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
    featurearts(page)
    otherarts(page)
  end

  def featurearts(page)
    page.css(".four-story--item").each do |info|
      title = info.css(".four-story--title a").text
      link = info.css(".four-story--title a").attr("href").text
      FeatureArt.new(title, link)
  end

  def scrape_article(feat)
    feat_page = Nokogiri::HTML(HTTParty.get(feat.link).body)
    feat.author = ffeat_page.css(".byline__name").text
    feat.biopart1 = feat_page.css("p")[2].text
    feat.biopart2 = feat_page.css("p")[3].text
    feat.date = feat_page.css(".content-header__publish-date").text
  end

  def otherarts(page)
    page.css(".feed-card").each do |info|
      title = info.css(" .feed-card--title a").text
      link = info.css(" .feed-card--title a").attr("href").text
      Article.new(title, link)
    end
  end

end
