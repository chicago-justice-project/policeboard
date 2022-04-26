class SuperHistoryController < ApplicationController
  def index
    @supers = Superintendent.order(last_name: :asc)
  end
  def terminationsByYear
    startTerm = params[:start_term]
    endTerm = params[:end_term]
    if endTerm=='undefined'
      endTerm='2099-01-01'
    end
    sql = "select count(*) as vote_count,to_char(date_decided,'YYYY') as year_decided, 'Recommended Terminations' as record_type from cases where recommended_outcome_id=1
      and date_decided is not null and date_decided>='"+startTerm+"' and date_decided<='"+endTerm+"' group by year_decided order by year_decided"
    @terminationsPerYear = ActiveRecord::Base.connection.execute(sql)
    render json: @terminationsPerYear
  end
  def recommendedTermsByYear
    startTerm = params[:start_term]
    endTerm = params[:end_term]
    if endTerm=='undefined'
      endTerm='2099-01-01'
    end
    sql = "select count(*) as vote_count,to_char(date_decided,'YYYY') as year_decided, 'Terminations' as record_type from cases where recommended_outcome_id=1
      and decided_outcome_id=1 and date_decided is not null and date_decided>='"+startTerm+"' and date_decided<='"+endTerm+"' group by year_decided order by year_decided"
    @recommendedTermsByYear = ActiveRecord::Base.connection.execute(sql)
    render json: @recommendedTermsByYear
  end
end
