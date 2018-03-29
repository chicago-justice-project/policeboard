require 'action_view'
include ActionView::Helpers::DateHelper

class Case < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  attr_accessor :tweet

  belongs_to :defendant
  belongs_to :recommended_outcome, :class_name => "Outcome"
  belongs_to :decided_outcome, :class_name => "Outcome"
  has_many :board_member_votes
  has_many :case_rules, :dependent => :destroy
  has_many :case_rule_counts, through: :case_rules
  has_many :complaints
  has_many :minority_opinions

  accepts_nested_attributes_for :minority_opinions
  accepts_nested_attributes_for :defendant
  accepts_nested_attributes_for :case_rules, :reject_if => lambda { |a| a[:rule_id].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :board_member_votes, :allow_destroy => true

  mount_uploaders :files, CaseFileUploader

  after_update :sort_case_rule_counts, :sort_case_rules

  after_save :send_tweet, if: Proc.new {|r| r.tweet == "true" }

  validates :number, presence: true
  validates_integrity_of :files

  self.per_page = 10

  def send_tweet
    case_url = case_url(self)
    Twitter.client.update("Case: #{defendant.full_name} #{case_url}")
  end

  def sort_case_rule_counts
  	self.case_rules.each do |case_rule|
  	  case_rule.case_rule_counts.order(:count_order).each_with_index  do |rule_count, index|
  	    rule_count.count_order = index + 1
  	    rule_count.save
  	  end
  	end

  end

  def sort_case_rules
	  self.case_rules.order(:rule_order).each_with_index do |case_rule, index|
		  case_rule.rule_order = index + 1
		  case_rule.save
	  end
  end


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
      .where(is_active:true)
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
      .where(is_active: true)
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
