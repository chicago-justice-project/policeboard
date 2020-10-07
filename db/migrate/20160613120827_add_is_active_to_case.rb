class AddIsActiveToCase < ActiveRecord::Migration[4.2]
  def change
    add_column :cases, :is_active, :boolean
  end
end
