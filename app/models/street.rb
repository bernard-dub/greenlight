class Street < ApplicationRecord
  has_and_belongs_to_many :cards
  
  acts_as_taggable_on :locations
  
  has_rich_text :body
  has_rich_text :comment
  
  validates_presence_of :name, :position, :houses
  
  default_scope {order(position: :asc)}
  
  def name_with_context
    integrated_name || "à la #{name}"
  end
  
  def default_cards
    Card.tagged_with(self.location)
  end
  
  def related_cards
    (self.cards + self.default_cards).uniq
  end
  
  def location
    locations.first
  end
  
end
