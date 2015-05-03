class Defendant < ActiveRecord::Base
  has_many :cases
  has_one :rank
  
  def full_name
    [first_name, last_name].join(' ')
  end
end
