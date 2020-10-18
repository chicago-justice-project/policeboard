class AddInvestigatedByToCases < ActiveRecord::Migration[6.0]
  def change
    add_column :cases, :investigated_by, :string
  end
end
