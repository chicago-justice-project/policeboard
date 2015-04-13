class Case < ActiveRecord::Base
  belongs_to :defendant 
  has_one :recommended_outcome, :class_name => "Outcome"
  has_one :decided_outcome, :class_name => "Outcome"
  has_many :board_member_votes
  has_many :case_rules
  has_many :complaints
end
