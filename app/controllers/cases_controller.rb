class CasesController < ApplicationController
  def index
    if params[:search]
      @header = "Search results"
      @cases = Case.search(params[:search])
        .paginate(:page => params[:page])
        .order('date_initiated IS NULL, date_initiated DESC')
    else
      @header = "Recent cases"
      @cases = Case.where.not(defendant_id: nil)
        .order('date_initiated IS NULL, date_initiated DESC')
        .paginate(:page => params[:page])
    end
  end

  def show
    @case = Case.find(params[:id])
    @files = Dir.glob("**/public/case_files/" + @case.number + "_*.pdf").map{|path| path.gsub("public/","") }
  end
end
