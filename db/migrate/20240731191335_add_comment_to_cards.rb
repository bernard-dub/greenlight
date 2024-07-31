class AddCommentToCards < ActiveRecord::Migration[7.1]
  def change
    add_column :cards, :comment, :text
  end
end
