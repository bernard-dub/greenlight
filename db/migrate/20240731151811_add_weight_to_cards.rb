class AddWeightToCards < ActiveRecord::Migration[7.1]
  def change
    add_column :cards, :weight, :decimal, :precision => 6, :scale => 5, :default => 0.5
  end
end
