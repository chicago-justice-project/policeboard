class AddCategoryToCases < ActiveRecord::Migration[4.2]
  def change
    add_column :cases, :category, :integer
  end
end
