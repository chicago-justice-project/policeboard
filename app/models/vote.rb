class Vote < ActiveRecord::Base
  def self.AGREE
    Vote.find_by_name("Agree").id
  end

  def self.DISSENT
    Vote.find_by_name("Dissent").id
  end

  def self.ABSTAIN
    Vote.find_by_name("Abstain").id
  end
end
