module Extranet
	class CasesController < Extranet::ApplicationController
	  def new
	  	@case = Case.new
	  	@case.build_defendant
	  end
	  
	  def create
	  	@case = Case.new(case_params)
	  	if @case.save
	  		redirect_to index, :notice => "Case successfully added"
	  	else
	  		flash[:error] = "Oops there was an error"
	  		render 'new'
	  	end
	  end
	  
	  private
	  def case_params
	    params.require(:case).permit(:number, :date_initiated, :date_decided, :recommended_outcome_id, :decided_outcome_id, 	
	      defendant_attributes: [:first_name, :last_name, :rank_id, :number])
	  end  
	end
end
