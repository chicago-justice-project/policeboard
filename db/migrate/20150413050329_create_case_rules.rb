class CreateCaseRules < ActiveRecord::Migration[4.2]
  def change
    create_table :case_rules do |t|
      t.references :case, index: true
      t.references :rule, index: true
      t.text :content
      t.boolean :is_guilty

      t.timestamps
    end
  end
end
