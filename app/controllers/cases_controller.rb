class CasesController < ApplicationController
  def index
    if params[:search]
      @header = "Search results"
      @cases = Case
        .joins(:defendant)
        .where("LOWER(cases.number) like :keyword " +
          "OR LOWER(defendants.first_name) like :keyword " + 
          "OR LOWER(defendants.last_name) like :keyword " + 
          "OR LOWER(defendants.first_name||' '||defendants.last_name) like :keyword " +
          "OR LOWER(defendants.number) like :keyword", 
          { keyword: "%" + params[:search].downcase + "%"})
        .where.not(defendant_id: nil)
        .order(date_initiated: :desc)
    else
      @header = "Recent cases"
      @cases = Case.where.not(defendant_id: nil, date_initiated: nil).order(date_initiated: :desc)
      @cases_date_initiated_nil = Case.where.not(defendant_id: nil).where(date_initiated: nil)
      @cases = @cases + @cases_date_initiated_nil
    end
  end

  def show
    @case = Case.find(params[:id])
  end
end
