class AddMajorityDecisionToCase < ActiveRecord::Migration
  def change
    add_column :cases, :majority_decision, :text
  end
end
