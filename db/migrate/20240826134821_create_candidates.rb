class CreateCandidates < ActiveRecord::Migration[7.1]
  def change
    create_table :candidates do |t|
      t.integer :position
      t.text :firstname
      t.text :lastname
      t.text :short_description
      t.text :body
      t.text :comment

      t.timestamps
    end
  end
end
