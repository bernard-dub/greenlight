class Street < ApplicationRecord
  has_and_belongs_to_many :cards, uniq: true
  belongs_to :parent, class_name: "Street", optional: true
  has_many :children, class_name: "Street", foreign_key: :parent_id, dependent: :destroy
  
  acts_as_taggable_on :locations
  
  has_rich_text :body
  has_rich_text :comment
  
  validates_presence_of :name, :position, :houses
  
  default_scope {order(position: :asc)}
  
  def name_with_context
    integrated_name.blank? ? "à la #{name}" : integrated_name
  end
  
  def default_cards
    Card.tagged_with(self.location)
  end
  
  def related_cards
    result = self.cards 
    result += self.parent.cards if self.has_parent
    result += self.default_cards
    result.uniq[0..8]
  end
  
  def location
    locations.first
  end
  
  def has_parent
    !self.parent.blank?
  end
  
  def has_children
    !self.children.empty?
  end
  
  def possible_parents
    Street.tagged_with(self.location) - [self] - Street.all_children
  end
  
  def self.all_children
    Street.all.select{|s|s.has_parent}
  end
    
  STATUSES = {'Non démarré'=> '#9ca3af', 'En cours'=> '#22d3ee', 'A valider'=> '#fbbf24', 'A imprimer'=> '#4ade80', 'Cloturé'=> '#6366f1'}
end
