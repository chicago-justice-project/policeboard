class AddImageToBoardMembers < ActiveRecord::Migration
  def change
    add_column :board_members, :image, :string
  end
end
