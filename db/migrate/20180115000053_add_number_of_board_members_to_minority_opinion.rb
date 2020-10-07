class AddNumberOfBoardMembersToMinorityOpinion < ActiveRecord::Migration[4.2]
  def change
    add_column :minority_opinions, :number_of_votes, :integer
  end
end
