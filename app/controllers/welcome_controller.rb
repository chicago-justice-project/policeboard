class WelcomeController < ApplicationController
  def index
    @cases = Case.where.not(recommended_outcome_id: nil, decided_outcome_id: nil)
    @case_outcomes = @cases.group(:recommended_outcome_id, :decided_outcome_id).count
    @board_members = BoardMember.order(board_position: :asc, last_name: :asc).select{ |bm| bm.active == true }
  end
end
