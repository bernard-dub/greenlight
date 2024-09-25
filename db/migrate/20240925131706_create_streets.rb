class CreateStreets < ActiveRecord::Migration[7.1]
  def change
    create_table :streets do |t|
      t.integer :position
      t.string :name
      t.string :integrated_name
      t.integer :houses
      t.text :body
      t.text :comment
      t.string :status
      
      t.timestamps
    end
    
    add_reference :streets, :parent, foreign_key: { to_table: :streets }
    
  end
end
