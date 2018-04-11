class AddAppealedToCases < ActiveRecord::Migration
  def change
    add_column :cases, :appealed, :boolean, default: false
  end
end
