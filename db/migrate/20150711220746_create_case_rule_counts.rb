class CreateCaseRuleCounts < ActiveRecord::Migration
  def change
    create_table :case_rule_counts do |t|
      t.references :case_rule, index: true
      t.integer :count_order
      t.text :content
      t.boolean :is_guilty

      t.timestamps
    end
  end
end
