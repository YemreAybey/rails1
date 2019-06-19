class Article < ApplicationRecord
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings
  
  def tag_list
    tags.join(", ")
  end

  def tag_list=(tags_str)
    list = tags_str.downcase.scan(/[A-Za-z\d]+/).uniq
    new_or_found_tags = list.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end
end
