# blueprint of object
# no puts, just stores instances of data i.e. attributes of articles

class Article
  attr_accessor :author, :date, :bio
  attr_reader :title, :link, :category, :featured, :id

  @@all = []

  def initialize(title, link, category, featured)
    @title = title
    @link = link
    @category = category
    @featured = featured
    @@all << self
    @id = @@all.count
  end

  def self.all
    @@all
  end

  def self.find_by_id(id)
    all.find { |article| article.id == id }
  end

  def self.featured_for_category(category)
    Article.all.select do |article|
      article.featured == true && article.category == category
    end
  end

  def self.more_articles_for_category(category)
    Article.all.select do |article|
      article.featured == false && article.category == category
    end
  end
end
