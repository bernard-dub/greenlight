class Card < ApplicationRecord
  attr_reader :new_images
  
  acts_as_taggable_on :locations, :topics, :statuses
  
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [500, 300]
  end
  
  has_rich_text :body
  
  validates_presence_of :title
  
  def self.tagged_with_id(id)
    ActsAsTaggableOn::Tag.find(id).taggings.map{|t|Card.find t.taggable_id}
  end
  
  def tags
    self.locations + self.topics + self.statuses
  end
  
  def new_images=(images)
    self.images.attach(images)
  end
  
  def persisted_images
    images.select(&:persisted?)
  end
  
end
