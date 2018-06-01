class AnalyticsController < ApplicationController
  
  def index
    start_year = (params[:start_year] || Date.today.year - 4).to_i
    end_year = (params[:end_year] || Date.today.year).to_i
    
    @cases_filed_by_year_range = (start_year..end_year).to_a
    total_cases = []
    decided_cases = []


    decided_outcome_ids = Outcome.where(name: ["Returned to Duty", "Settlement", "Suspension", "Termination"]).map(&:id)
    @cases_filed_by_year_range.each do |year|
      puts year
      cases_per_year = Case.where('extract(year from date_initiated) = ?', year)
      decisions_per_year = Case.where('extract(year from date_decided) = ?', year).where(decided_outcome_id: decided_outcome_ids)

      total_cases.push(cases_per_year.count) 
      decided_cases.push(decisions_per_year.count) 
    end

    @cases_filed_by_year_series = [
      {
        name: 'Total cases',
        data: total_cases
      },
      {
        name: 'Decided cases',
        data: decided_cases
      }
    ]

  end

end

