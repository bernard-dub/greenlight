class Card < ApplicationRecord
  attr_reader :new_images
  
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [500, 300]
  end
  
  has_rich_text :body
  
  def new_images=(images)
    self.images.attach(images)
  end
  
  def persisted_images
    images.select(&:persisted?)
  end
  
end
