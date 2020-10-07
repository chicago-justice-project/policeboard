class AddRankToDefendant < ActiveRecord::Migration[4.2]
  def change
    add_reference :defendants, :rank, index: true
  end
end
