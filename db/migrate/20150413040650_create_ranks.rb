class CreateRanks < ActiveRecord::Migration[4.2]
  def change
    create_table :ranks do |t|
      t.string :name
      t.boolean :is_civilian
      t.references :defendant, index: true

      t.timestamps
    end
  end
end
