class CreatePages < ActiveRecord::Migration[7.1]
  def change
    create_table :pages do |t|
      t.string :title
      t.string :subtitle
      t.text :body
      t.boolean :published
      t.decimal :weight, :precision => 6, :scale => 5, :default => 0.5
      t.text :comment
      
      t.timestamps
    end
  end
end