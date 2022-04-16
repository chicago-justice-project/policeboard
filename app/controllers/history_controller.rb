class HistoryController < ApplicationController
  def index
    @board_members = BoardMember.order(board_position: :asc, last_name: :asc)
  end
  def all
    @history = SuperintendentHistory.all
    render json: @history
  end
  def member
    @history = SuperintendentHistory.where(board_member_id: params[:board_member_id])
    render json: @history
  end
  def terminationsByYear
    sql = "select count(*) as vote_count,to_char(date_decided,'YYYY') as year_decided, 'ALL' as last_name from cases where decided_outcome_id=1
      and date_decided is not null and date_decided>'1990-01-01' group by year_decided order by year_decided"
    @terminationsPerYear = ActiveRecord::Base.connection.execute(sql)
    render json: @terminationsPerYear
  end

end
