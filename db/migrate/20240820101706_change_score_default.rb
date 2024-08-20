class ChangeScoreDefault < ActiveRecord::Migration[7.1]
  def change
    change_column_default :cards, :score, from: nil, to: 0
  end
end
