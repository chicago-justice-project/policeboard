class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.integer :code
      t.text :description
      t.text :comment

      t.timestamps
    end
  end
end
