class BoardMember < ActiveRecord::Base
  has_many :cases, through: :board_member_votes
  has_many :board_member_votes
  has_many :terms
  
  def active
    self.terms.each do |term|
      if term.end && term.end >= DateTime.now.to_date
        return true
      end
    end
    return false
  end
    
  def full_name
    [first_name, last_name].join(' ')
  end
  
  def initial 
    [first_name[0], last_name[0]].join()
  end
end
