class BoardMemberVote < ActiveRecord::Base
  belongs_to :case
  belongs_to :board_member
  belongs_to :vote, optional: true
  has_rich_text :dissent_description
end
