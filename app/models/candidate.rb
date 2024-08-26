class Candidate < ApplicationRecord
  attr_reader :new_images
  
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [600, 400]
  end
  
  acts_as_taggable_on :locations
  
  has_rich_text :body
  has_rich_text :comment
  
  validates_presence_of :position, :firstname, :lastname, :short_description
  
  default_scope {order(position: :asc)}
  
  def new_images=(images)
    self.images.attach(images)
  end
  
  def persisted_images
    images.select(&:persisted?)
  end
end
