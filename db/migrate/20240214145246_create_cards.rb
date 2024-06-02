class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.string :title
      t.text :body
      t.boolean :published

      t.timestamps
    end
  end
end
