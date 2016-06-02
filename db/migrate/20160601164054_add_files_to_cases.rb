class AddFilesToCases < ActiveRecord::Migration
  def change
    add_column :cases, :files, :json
  end
end
