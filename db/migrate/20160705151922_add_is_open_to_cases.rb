class AddIsOpenToCases < ActiveRecord::Migration[4.2]
  def change
    add_column :cases, :is_open, :boolean
  end
end
