class CreateOutcomes < ActiveRecord::Migration[4.2]
  def change
    create_table :outcomes do |t|
      t.string :name

      t.timestamps
    end
  end
end
