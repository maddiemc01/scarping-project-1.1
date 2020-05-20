class FeatureArt
  attr_accessor :title, :author, :link, :date, :biopart1, :biopart2, :id

  @@all = []

  def initialize(title = nil, link = nil)
    @title = title
    @link = link
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