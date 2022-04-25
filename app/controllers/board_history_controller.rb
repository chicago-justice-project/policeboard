class BoardHistoryController < ApplicationController
  def index
    @board_members = BoardMember.order(board_position: :asc, last_name: :asc)
  end
  def all
    @history = BoardMemberHistory.all
    render json: @history
  end
  def memberTerms
    @board_member = BoardMember.find(params[:board_member_id])
    render json: @board_member.terms
  end
  def memberVotes
    @history = BoardMemberHistory.where(board_member_id: params[:board_member_id])
    render json: @history
  end
  def terminationsByYear
    sql = "select count(*) as vote_count,to_char(date_decided,'YYYY') as year_decided, 'All Recommended Terminations' as last_name, 'Recommended' as outcome_label from cases where recommended_outcome_id=1
      and date_decided is not null and date_decided>'1990-01-01' group by year_decided order by year_decided"
    @terminationsPerYear = ActiveRecord::Base.connection.execute(sql)
    render json: @terminationsPerYear
  end
  def recommendedTermsByYear
    sql = "select count(*) as vote_count,to_char(date_decided,'YYYY') as year_decided, 'All Terminations' as last_name, 'Terminated' as outcome_label from cases where recommended_outcome_id=1
      and decided_outcome_id=1 and date_decided is not null and date_decided>'1990-01-01' group by year_decided order by year_decided"
    @recommendedTermsByYear = ActiveRecord::Base.connection.execute(sql)
    render json: @recommendedTermsByYear
  end

end
