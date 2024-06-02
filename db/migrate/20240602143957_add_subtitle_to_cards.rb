class AddSubtitleToCards < ActiveRecord::Migration[7.1]
  def change
    add_column :cards, :subtitle, :text
  end
end
