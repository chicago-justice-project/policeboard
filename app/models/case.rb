require 'action_view'
include ActionView::Helpers::DateHelper

class Case < ActiveRecord::Base
  belongs_to :defendant
  belongs_to :recommended_outcome, :class_name => "Outcome"
  belongs_to :decided_outcome, :class_name => "Outcome"
  has_many :board_member_votes
  has_many :case_rules
  has_many :case_rule_counts, through: :case_rules
  has_many :complaints

  def agree_votes
    self.board_member_votes.where(vote_id: Vote.AGREE).map{|bmv| bmv.board_member}
  end

  def dissent_votes
    self.board_member_votes.where(vote_id: Vote.DISSENT).map{|bmv| bmv.board_member}
  end

  def abstain_votes
    self.board_member_votes.where(vote_id: Vote.ABSTAIN).map{|bmv| bmv.board_member}
  end

  def length_of_process
    if !date_initiated.nil? && !date_decided.nil?
      distance_of_time_in_words(date_initiated, date_decided)
    end
  end
end
