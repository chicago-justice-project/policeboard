class CreateCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.references :authority, index: true

      t.timestamps
    end
  end
end
