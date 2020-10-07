class AddImageToBoardMembers < ActiveRecord::Migration[4.2]
  def change
    add_column :board_members, :image, :string
  end
end
