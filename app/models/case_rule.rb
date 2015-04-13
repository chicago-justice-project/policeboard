class CaseRule < ActiveRecord::Base
  belongs_to :case
  belongs_to :rule
end
