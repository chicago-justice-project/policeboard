class BoardMemberHistory < ActiveRecord::Base
  def readonly?
    true
  end
end