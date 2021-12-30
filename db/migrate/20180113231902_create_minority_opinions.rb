class CreateMinorityOpinions < ActiveRecord::Migration[4.2]
  def change
    create_table :minority_opinions do |t|

      t.timestamps null: false
    end
  end
end
