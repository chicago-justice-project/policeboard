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

  def votes_total_count
    BoardMemberVote.where(board_member_id: id).count
  end

  def votes_abstain_count
    BoardMemberVote.where(board_member_id: id, vote_id: Vote.ABSTAIN).count
  end

  def votes_abstain_rate
    (votes_abstain_count.to_f / votes_total_count * 100).round
  end

  def votes_dissent_count
    BoardMemberVote.where(board_member_id: id, vote_id: Vote.DISSENT).count
  end

  def votes_dissent_rate
    (votes_dissent_count.to_f / votes_total_count * 100).round
  end

  def votes_agree_count
    agree_vote_id = Vote.find_by_name("Agree")
    BoardMemberVote.where(board_member_id: id, vote_id: Vote.AGREE).count
  end

  def votes_agree_rate
    (votes_agree_count.to_f / votes_total_count * 100).round
  end
end
