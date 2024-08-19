class AddScoreToCards < ActiveRecord::Migration[7.1]
  def change
    add_column :cards, :score, :integer
  end
end
