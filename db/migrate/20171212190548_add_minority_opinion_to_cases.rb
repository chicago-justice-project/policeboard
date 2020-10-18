class AddMinorityOpinionToCases < ActiveRecord::Migration[4.2]
  def change
    add_column :cases, :minority_opinion, :text
  end
end
