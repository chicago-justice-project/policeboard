class HistoryController < ApplicationController
  def index
    @board_members = BoardMember.order(board_position: :asc, last_name: :asc)
  end
  def all
    @history = SuperintendentHistory.all
    render json: @history
  end
  def terminationsByYear

  end

end
