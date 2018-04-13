class UpdateMinorityOpnionsAssociations < ActiveRecord::Migration
  def change
    MinorityOpinion.where(board_member_one: '').update_all(board_member_one: nil)
    MinorityOpinion.where(board_member_two: '').update_all(board_member_two: nil)
    MinorityOpinion.where(board_member_three: '').update_all(board_member_three: nil)
    MinorityOpinion.where(board_member_four: '').update_all(board_member_four: nil)

    change_column :minority_opinions, :board_member_one, 'integer USING CAST(board_member_one AS integer)'
    change_column :minority_opinions, :board_member_two, 'integer USING CAST(board_member_two AS integer)'
    change_column :minority_opinions, :board_member_three, 'integer USING CAST(board_member_three AS integer)'
    change_column :minority_opinions, :board_member_four, 'integer USING CAST(board_member_four AS integer)'

    rename_column :minority_opinions, :board_member_one, :board_member_one_id
    rename_column :minority_opinions, :board_member_two, :board_member_two_id
    rename_column :minority_opinions, :board_member_three, :board_member_three_id
    rename_column :minority_opinions, :board_member_four, :board_member_four_id

    add_index :minority_opinions, :board_member_one_id
    add_index :minority_opinions, :board_member_two_id
    add_index :minority_opinions, :board_member_three_id
    add_index :minority_opinions, :board_member_four_id
  end
end
