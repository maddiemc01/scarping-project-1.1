class Category
  attr_accessor :name, :url, :feature, :otherart, :scraped, :article

  @@all = []

  def initialize(name = nil, url = nil)
    @name = name
    @url = url
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find_by_name(name)
    all.find { |category| category.name == name }
  end
end
