class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.date :start
      t.date :end
      t.references :board_member, index: true

      t.timestamps
    end
  end
end
