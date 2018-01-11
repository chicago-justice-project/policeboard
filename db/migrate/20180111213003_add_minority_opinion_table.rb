class AddMinorityOpinionTable < ActiveRecord::Migration
  def change
    remove_column :cases, :minority_opinion, :text
    create_table :minority_opinion do |t|
      t.integer :case_id
      t.text :opinion_text
    end
  end
end
