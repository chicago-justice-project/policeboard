class CreateBoardMembers < ActiveRecord::Migration
  def change
    create_table :board_members do |t|
      t.string :first_name
      t.string :last_name
      t.string :board_position
      t.string :job_title
      t.string :organization
      t.string :facebook_handle
      t.string :twitter_handle
      t.string :linkedin_handle

      t.timestamps
    end
  end
end
