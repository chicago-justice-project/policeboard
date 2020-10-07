class CreateBoardMemberVotes < ActiveRecord::Migration[4.2]
  def change
    create_table :board_member_votes do |t|
      t.references :case, index: true
      t.references :board_member, index: true
      t.references :vote, index: true
      t.text :dissent_description

      t.timestamps
    end
  end
end
