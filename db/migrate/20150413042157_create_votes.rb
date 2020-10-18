class CreateVotes < ActiveRecord::Migration[4.2]
  def change
    create_table :votes do |t|
      t.string :name

      t.timestamps
    end
  end
end
