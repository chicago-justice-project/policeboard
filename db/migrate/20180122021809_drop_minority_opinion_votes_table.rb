class DropMinorityOpinionVotesTable < ActiveRecord::Migration
  def change
    drop_table :minority_opinion_votes
  end
end
