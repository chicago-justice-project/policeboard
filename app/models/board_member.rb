class BoardMember < ActiveRecord::Base
  has_many :cases, through: :board_member_votes
  has_many :board_member_votes
  has_many :terms

  accepts_nested_attributes_for :terms, :allow_destroy => true
  
  def active
    self.terms.each do |term|
      if term.end && term.end >= DateTime.now.to_date
        return true
      end
    end
    return false
  end
  
  def photo
    board_dir = "board-members/"
    photo = [board_dir, full_name.downcase.gsub(' ','-').gsub('.',''), ".jpg"].join
    File.exists?([Rails.root, "/app/assets/images/", photo].join) ? photo : "#{board_dir}placeholder.jpg"
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  def votes_total_count
    total = BoardMemberVote.where(board_member_id: id).count
    total == 0 ? 1 : total
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

  def status
    if active 
      return 'current'
    else
      return 'past'
    end
    
  end
end
