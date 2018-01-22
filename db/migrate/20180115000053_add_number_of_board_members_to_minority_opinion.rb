class AddNumberOfBoardMembersToMinorityOpinion < ActiveRecord::Migration
  def change
    add_column :minority_opinions, :number_of_votes, :integer
  end
end
