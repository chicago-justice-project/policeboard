class Term < ActiveRecord::Base
  belongs_to :board_member

  def start_at_string
    self.start.nil? ? "" : start.to_s(:db)
  end

  def start_at_string=(start_at_string)
    self.start = Time.parse(start_at_string)
  end
end
