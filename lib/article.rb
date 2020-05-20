# blueprint of object
# no puts, just stores instances of data i.e. attributes of articles

class Article
  attr_accessor :title, :author, :url, :date, :biopart1, :biopart2, :id

  @@all = []

  def initialize(title = nil, author = nil, url = nil)
    @title = title
    @author = author
    @url = url
    @@all << self
    @id = @@all.count
  end

  def self.all
    @@all
  end

  def self.find_by_id(id)
    all.find { |article| article.id == id }
  end
end
