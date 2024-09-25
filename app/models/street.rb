class Street < ApplicationRecord
  # has_and_belongs_to_many :cards
  
  acts_as_taggable_on :locations
  
  has_rich_text :body
  has_rich_text :comment
  
  validates_presence_of :name, :position, :houses
  
  default_scope {order(position: :asc)}
  
  def name_with_context
    integrated_name || "la #{name}"
  end
  
end
