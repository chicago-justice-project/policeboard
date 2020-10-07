class CreateAuthorities < ActiveRecord::Migration[4.2]
  def change
    create_table :authorities do |t|
      t.string :name

      t.timestamps
    end
  end
end
