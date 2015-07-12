class AddCaseRuleOrder < ActiveRecord::Migration
  def change
    remove_column :case_rules, :content, :text
    remove_column :case_rules, :is_guilty, :boolean
    add_column :case_rules, :rule_order, :integer
  end
end
