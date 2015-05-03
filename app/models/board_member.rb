class BoardMember < ActiveRecord::Base
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
end
