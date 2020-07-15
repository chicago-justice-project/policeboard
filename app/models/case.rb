require 'action_view'
include ActionView::Helpers::DateHelper
include CaseSearch

class Case < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  attr_accessor :tweet_charges, :search_text
  attr_accessor :tweet_decision

  belongs_to :defendant
  belongs_to :recommended_outcome, :class_name => "Outcome"
  belongs_to :decided_outcome, :class_name => "Outcome"
  has_many :board_member_votes
  has_many :case_rules, :dependent => :destroy
  has_many :case_rule_counts, through: :case_rules
  has_many :complaints
  has_many :minority_opinions
  has_many :case_text_files

  accepts_nested_attributes_for :minority_opinions
  accepts_nested_attributes_for :defendant
  accepts_nested_attributes_for :case_rules, :reject_if => lambda { |a| a[:rule_id].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :board_member_votes, :allow_destroy => true

  mount_uploaders :files, CaseFileUploader

  enum category: ["Excessive Force--On Duty", "Other On-Duty Misconduct", "Domestic Altercation--Off Duty", "Other Off-Duty Misconduct", "Drug/Alcohol Abuse", "Bribery/Official Corruption", "Commission of a Crime", "Conduct Unbecoming--Off Duty", "Operation/Personnel Violations", "Other (BIA)"]

  after_update :sort_case_rule_counts, :sort_case_rules

  after_save :send_tweet_charges, if: Proc.new {|r| r.tweet_charges == "true" }
  after_save :send_tweet_decision, if: Proc.new {|r| r.tweet_decision == "true" }

  validates :number, presence: true
  validates_integrity_of :files

  self.per_page = 10

  def send_tweet_charges
    return unless defendant.present?

    message = "Alert: New case filed with Police Board against #{defendant.rank.name} #{defendant.full_name} - #{number} - read the charges #{case_url(self)}"
    Twitter.client.update(message)
  end

  def send_tweet_decision
    return unless defendant.present?

    message = "Alert: New decision handed down by Police Board against #{defendant.rank.name} #{defendant.full_name} - #{number} - read the decision #{case_url(self)}"
    Twitter.client.update(message)
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

  def search_blurb
    search_text if defined?(search_text)
  end

  class << self
    def count_per_year_for_outcome(recommended_outcome_id, decided_outcome_id)
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
end
