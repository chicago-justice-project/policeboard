class CaseRuleCount < ActiveRecord::Base
  belongs_to :case_rule
  has_rich_text :content
end
