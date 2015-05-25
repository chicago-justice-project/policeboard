class Defendant < ActiveRecord::Base
  has_many :cases
  belongs_to :rank

  def full_name
    [first_name, last_name].join(' ')
  end
end
