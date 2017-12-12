class AddMinorityOpinionToCases < ActiveRecord::Migration
  def change
    add_column :cases, :minority_opinion, :text
  end
end
