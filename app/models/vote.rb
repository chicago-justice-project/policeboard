class Vote < ActiveRecord::Base
  def self.AGREE
    Vote.find_by_name("Agree").try(:id)
  end

  def self.DISSENT
    Vote.find_by_name("Dissent").try(:id)
  end

  def self.ABSTAIN
    Vote.find_by_name("Abstain").try(:id)
  end
end
