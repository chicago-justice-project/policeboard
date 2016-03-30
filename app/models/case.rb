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
  
  accepts_nested_attributes_for :defendant

  self.per_page = 10

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

  def self.search(keyword)
    Case
      .joins(:defendant)
      .where.not(defendant_id: nil)
      .where("LOWER(cases.number) LIKE :keyword " + 
        "OR LOWER(defendants.first_name) LIKE :keyword " + 
        "OR LOWER(defendants.last_name) LIKE :keyword " +
        "OR LOWER(defendants.first_name||' '||defendants.last_name) LIKE :keyword " + 
        "OR LOWER(defendants.number) LIKE :keyword",
        { keyword: '%' + keyword.downcase + '%' })
  end
  
  def self.count_per_year_for_outcome(recommended_outcome_id, decided_outcome_id)
    @count_per_year = Case
      .where.not(date_initiated: nil)
      .where(recommended_outcome_id: recommended_outcome_id, decided_outcome_id: decided_outcome_id)
      .order('EXTRACT(YEAR from date_initiated)')
      .group('EXTRACT(YEAR from date_initiated)')
      .count
    @count = []
    (@count_per_year.keys.first.to_i..@count_per_year.keys.last.to_i).each do |year|
      @count << (@count_per_year[year.to_f] || 0)
    end
    @count
  end
end
