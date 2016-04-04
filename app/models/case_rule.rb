class CaseRule < ActiveRecord::Base
  belongs_to :case
  belongs_to :rule
  has_many :case_rule_counts  

  accepts_nested_attributes_for :case_rule_counts
  
end
