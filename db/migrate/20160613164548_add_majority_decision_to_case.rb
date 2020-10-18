class AddMajorityDecisionToCase < ActiveRecord::Migration[4.2]
  def change
    add_column :cases, :majority_decision, :text
  end
end
