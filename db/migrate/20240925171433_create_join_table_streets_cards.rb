class CreateJoinTableStreetsCards < ActiveRecord::Migration[7.1]
  def change
    create_join_table :streets, :cards do |t|
      # t.index [:street_id, :card_id]
      # t.index [:card_id, :street_id]
    end
  end
end
