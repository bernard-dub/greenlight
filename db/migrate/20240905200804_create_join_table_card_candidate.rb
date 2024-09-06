class CreateJoinTableCardCandidate < ActiveRecord::Migration[7.1]
  def change
    create_join_table :cards, :candidates do |t|
      # t.index [:card_id, :candidate_id]
      # t.index [:candidate_id, :card_id]
    end
  end
end
