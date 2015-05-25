class BoardController < ApplicationController
  def index
    board_members = BoardMember.order(board_position: :asc, last_name: :asc)
    @current_board_members = board_members.select{ |bm| bm.active == true }
    @past_board_members = board_members.select{ |bm| bm.active == false }
  end

  def show
    @member = BoardMember.find(params[:id])
  end

  def responsibilities
  end
end
