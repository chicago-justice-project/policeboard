class WelcomeController < ApplicationController
  def index
    @board_members = BoardMember.order(board_position: :asc, last_name: :asc).select{ |bm| bm.active == true }
  end
end
