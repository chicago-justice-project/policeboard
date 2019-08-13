class CreateSuperintendents < ActiveRecord::Migration
  def change
    create_table :superintendents do |t|
      t.string :first_name
      t.string :last_name
      t.date :start_of_term
      t.date :end_of_term

      t.timestamps null: false
    end
  end
end
