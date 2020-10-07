class RemoveDefendantFromRanks < ActiveRecord::Migration[4.2]
  def change
    remove_reference :ranks, :defendant, index: true
  end
end
