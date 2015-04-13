class RemoveDefendantFromRanks < ActiveRecord::Migration
  def change
    remove_reference :ranks, :defendant, index: true
  end
end
