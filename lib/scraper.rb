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

# optimize so nothing is ever scraped twice
  # scrapes all the articles under category instance
  def scrape_category(categ)
    unless categ.scraped
      page = Nokogiri::HTML(HTTParty.get(categ.url).body)
      featurearts(page)
      otherarts(page)
      categ.scraped = true
    end
  end

  def featurearts(page)
    page.css(".four-story--item").each do |info|
      title = info.css(".four-story--title a").text
      link = info.css(".four-story--title a").attr("href").text
      FeatureArt.new(title, link)
    end
  end

  def scrape_article(artfet)
    artfet_page = Nokogiri::HTML(HTTParty.get(artfet.link).body)
    artfet.author = artfet_page.css(".byline__name").text
    artfet.biopart1 = artfet_page.css("p")[2].text
    artfet.biopart2 = artfet_page.css("p")[3].text
    artfet.date = artfet_page.css(".content-header__publish-date").text
  end

  def otherarts(page)
    page.css(".feed-card").each do |info|
      title = info.css(".feed-card--title a").text
      link = info.css(".feed-card--title a").attr("href").text
      Article.new(title, link)
    end
  end
end
