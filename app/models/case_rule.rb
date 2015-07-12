class CaseRule < ActiveRecord::Base
  belongs_to :case
  belongs_to :rule
  has_many :case_rule_counts
end
