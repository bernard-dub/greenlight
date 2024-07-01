class AddPublishedToCards < ActiveRecord::Migration[7.1]
  def change
    #published booleabn already exists ;-)
    #add_column :cards, :published, :boolean
    Card.update_all :published => true
  end
end
