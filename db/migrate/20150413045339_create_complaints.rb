class CreateComplaints < ActiveRecord::Migration[4.2]
  def change
    create_table :complaints do |t|
      t.string :number
      t.references :case, index: true

      t.timestamps
    end
  end
end
