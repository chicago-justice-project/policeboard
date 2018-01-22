class AddMinorityOpinionTextToMinorityOpinion < ActiveRecord::Migration
  def change
    add_column :minority_opinions, :opinion_text, :text
    add_column :minority_opinions, :case_id, :integer
    drop_table :minority_opinion
  end
end
