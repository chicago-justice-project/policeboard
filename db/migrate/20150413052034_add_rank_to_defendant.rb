class AddRankToDefendant < ActiveRecord::Migration
  def change
    add_reference :defendants, :rank, index: true
  end
end
