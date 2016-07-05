class AddIsOpenToCases < ActiveRecord::Migration
  def change
    add_column :cases, :is_open, :boolean
  end
end
