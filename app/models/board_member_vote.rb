class BoardMemberVote < ActiveRecord::Base
  belongs_to :case
  belongs_to :board_member
  has_one :vote
end
