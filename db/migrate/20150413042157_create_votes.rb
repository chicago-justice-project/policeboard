class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :name

      t.timestamps
    end
  end
end
