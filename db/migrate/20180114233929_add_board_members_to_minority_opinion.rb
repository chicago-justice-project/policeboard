class AddBoardMembersToMinorityOpinion < ActiveRecord::Migration[4.2]
  def change
    add_column :minority_opinions, :board_member_one, :string
    add_column :minority_opinions, :board_member_two, :string
    add_column :minority_opinions, :board_member_three, :string
    add_column :minority_opinions, :board_member_four, :string
  end
end
