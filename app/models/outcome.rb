class Outcome < ActiveRecord::Base
    @outcomes = Hash[
        "termination" => 1, 
        "suspension" => 2,
        "return to duty" => 3,
        "resignation" => 4,
        "death" => 5,
        "settlement agreement" => 6,
        "other" => 7]

    # Get id for outcome without making a call to the db
    def self.get_outcome_id(outcome)
        outcome = outcome.downcase
        @outcomes[outcome]
    end
end
