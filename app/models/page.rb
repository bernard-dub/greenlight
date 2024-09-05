class Page < ApplicationRecord
  attr_reader :new_images
  
  acts_as_taggable_on :locations, :topics, :statuses
  
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [600, 400]
  end
  
  has_and_belongs_to_many :cards
  
  has_rich_text :body
  has_rich_text :comment
  
  validates_presence_of :title
  validates :weight, numericality: {:in => (0.0...1.0)}
  
  default_scope { order(weight: :asc) }
  scope :published, -> { where(published: true) }
  
  def self.by_comment
    self.select{|card|!card.comment.blank?}.sort_by(&:updated_at).reverse
  end
  
  def self.tagged_with_id(id)
    ActsAsTaggableOn::Tag.find(id).taggings.map{|t|Card.find t.taggable_id}
  end
  
  def tags
    self.locations + self.topics + self.statuses
  end
  
  def first?
    self == Page.all.first
  end
  
  def last?
    self == Page.all.last
  end
  
  def prev
    pages = Page.all
    index = self.first? ? -1 : pages.find_index(self)-1
    pages[index]
  end
  
  def next
    pages = Page.all
    index = self.last? ? 0 : pages.find_index(self)+1
    pages[index]
  end
  
  def new_images=(images)
    self.images.attach(images)
  end
  
  def persisted_images
    images.select(&:persisted?)
  end
end
