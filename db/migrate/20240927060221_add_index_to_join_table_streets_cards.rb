class AddIndexToJoinTableStreetsCards < ActiveRecord::Migration[7.1]
  def change
    add_index :cards_streets, [ :card_id, :street_id ], :unique => true, :name => 'by_card_and_street'
  end
end
