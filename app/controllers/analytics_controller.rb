class AnalyticsController < ApplicationController
  before_action :cases_filed_by_year, :terminations_by_superintendent

  def terminations_by_superintendent
    @superintendents = Superintendent.order(start_of_term: :desc)
    datasets = []
    max_num_years = 0 #used to determine how many years will be displayed for x axis on graph

    @superintendents.each_with_index do |su, i|
      num_cases_termination_recommended = []
      num_cases_termination_decided = []
      curr_year_start = su.start_of_term
      su.end_of_term = Date.today if su.end_of_term.nil? #make sure end of term is not nil
      
      #count number of cases for each year of superintendents tenure
      while curr_year_start < su.end_of_term do
        if curr_year_start.next_year(1).prev_day.to_date < su.end_of_term
          curr_year_end = curr_year_start.next_year(1).prev_day.to_date
        else
          curr_year_end = su.end_of_term
        end

        num_cases_termination_recommended
        .push(Case.count_for_outcome(curr_year_start, curr_year_end, Outcome.get_outcome_id("Termination"), 0))

        num_cases_termination_decided
        .push(Case.count_for_outcome(curr_year_start, curr_year_end, 0, Outcome.get_outcome_id("Termination")))

        #move forward by one year
        curr_year_start = curr_year_start.next_year(1).to_date
      end

      selected = i == 0 ? true : false

      datasets.push({
        id: su.id,
        num_cases_termination_recommended: num_cases_termination_recommended,
        num_cases_termination_decided: num_cases_termination_decided,
        selected: selected
      })

      max_num_years = num_cases_termination_decided.count if num_cases_termination_decided.count > max_num_years
    end

    labels = *(1..max_num_years)
    @terminations_by_superintendent_data = Hash("datasets" => datasets, "labels" => labels)
  end

  def cases_filed_by_year
    start_year = (params[:start_year] || Date.today.year - 4).to_i
    end_year = (params[:end_year] || Date.today.year).to_i
    
    @cases_filed_by_year_range = (start_year..end_year).to_a
    total_cases = []
    decided_cases = []


    recommended_outcome_ids = Outcome.where(name: ["Suspension", "Termination"]).map(&:id)
    decided_outcome_ids = Outcome.where(name: ["Returned to Duty", "Settlement", "Suspension", "Termination"]).map(&:id)
    rank_ids = Rank.where(name: ["Police Officer", "Detective", "Gang Crimes Specialist", "Lieutenant", "Sargeant"]).map(&:id)


    @cases_filed_by_year_range.each do |year|
      cases_per_year = Case.includes(:defendant).where('extract(year from date_initiated) = ?', year).where(recommended_outcome_id: recommended_outcome_ids).where(:defendants => {rank_id: rank_ids})
      decisions_per_year = Case.includes(:defendant).where('extract(year from date_decided) = ?', year).where(decided_outcome_id: decided_outcome_ids).where(:defendants => {rank_id: rank_ids})

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

