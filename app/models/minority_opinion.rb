class MinorityOpinion < ActiveRecord::Base
  belongs_to :case

  belongs_to :board_member_one, class_name: "BoardMember"
  belongs_to :board_member_two, class_name: "BoardMember"
  belongs_to :board_member_three, class_name: "BoardMember"
  belongs_to :board_member_four, class_name: "BoardMember"
  has_rich_text :opinion_text
end
