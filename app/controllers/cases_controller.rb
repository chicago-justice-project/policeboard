class CasesController < ApplicationController
  def index
    if params[:search]
      @header = "Search results"
      @cases = Case.search(params[:search], params[:search_type], page: params[:page])
      @counter = "Matching cases: #{@cases.count}"
    else
      @header = "Recent cases"
      @cases = Case.where(is_active: true).where.not(defendant_id: nil)
                   .order('date_initiated IS NULL, date_initiated DESC')
                   .paginate(page: params[:page])
      @counter = "Total cases: #{@cases.count}"
   end

    @cases_per_year = Case.where('date_initiated IS NOT NULL')
      .order('EXTRACT(YEAR from date_initiated)')
      .group('EXTRACT(YEAR from date_initiated)')
      .count
    @case_trend = []
    (@cases_per_year.keys.first.to_i..@cases_per_year.keys.last.to_i).each do |year|
      @case_trend << (@cases_per_year[year.to_f] || 0)
    end
    @search_category = Case::SEARCH_CATEGORIES.first

    # @cases ||= CaseView.collection(xcases, view_context)
  end

  def show
    @case = Case.find(params[:id])
    if !@case.is_active
       redirect_to cases_path, :notice =>"Case not found"
    end

    # @case ||= CaseView.new(@case, view_context)
    #@files = Dir.glob("**/public/case_files/" + @case.number + "_*.pdf").map{|path| path.gsub("public/","/") }
  end

end
