class CreateJoinTableCardPage < ActiveRecord::Migration[7.1]
  def change
    create_join_table :cards, :pages do |t|
      # t.index [:card_id, :page_id]
      # t.index [:page_id, :card_id]
    end
  end
end
