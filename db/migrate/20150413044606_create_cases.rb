class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
      t.string :number
      t.references :defendant, index: true
      t.date :date_initiated
      t.date :date_decided
      t.references :recommended_outcome, index: true
      t.references :decided_outcome, index: true

      t.timestamps
    end
  end
end
