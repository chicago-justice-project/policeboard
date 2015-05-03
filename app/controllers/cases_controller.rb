class CasesController < ApplicationController
  def index
    @cases = Case.where.not(defendant_id: nil).order(:date_initiated)
  end
  
  def show
    @case = Case.find(params[:id])
  end
end