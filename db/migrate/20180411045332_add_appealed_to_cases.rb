class AddAppealedToCases < ActiveRecord::Migration[4.2]
  def change
    add_column :cases, :appealed, :boolean, default: false
  end
end
