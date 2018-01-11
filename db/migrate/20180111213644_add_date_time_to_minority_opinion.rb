class AddDateTimeToMinorityOpinion < ActiveRecord::Migration
  def change
    add_column :minority_opinion, :created_at, :datetime
    add_column :minority_opinion, :updated_at, :datetime
  end
end
