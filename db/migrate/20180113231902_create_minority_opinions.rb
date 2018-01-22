class CreateMinorityOpinions < ActiveRecord::Migration
  def change
    create_table :minority_opinions do |t|

      t.timestamps null: false
    end
  end
end
