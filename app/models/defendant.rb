class Defendant < ActiveRecord::Base
  has_many :cases
end
