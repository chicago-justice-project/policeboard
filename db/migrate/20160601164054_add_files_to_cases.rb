class AddFilesToCases < ActiveRecord::Migration[4.2]
  def change
    add_column :cases, :files, :json
  end
end
