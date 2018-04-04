class AddCategoryToCases < ActiveRecord::Migration
  def change
    add_column :cases, :category, :integer
  end
end
