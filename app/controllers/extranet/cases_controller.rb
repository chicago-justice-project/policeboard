module Extranet
	class CasesController < Extranet::ApplicationController
	  def index
	    @cases = Case.all
	  end
	  
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
	  
	  def edit
	    @case = Case.find(params[:id])
	  end
	  
	  def update
	  	@c = Case.find(params[:id])
	  	if @c.update(case_params)
	  	  redirect_to @c, :notice => "Case successfully updated"
	  	else
	  	  render :action => 'edit'	  	
	  	end
	  	
	  end
	  
	  def show
	    @case = Case.find(params[:id])
	  end
	  
	  def destroy
	  	@case = Case.find(params[:id])
	  	@case.destroy
	  	flash[:notice] = "Case deleted"
	  	redirect_to extranet_cases_path	  
	  end
	  
	  
	  private
	  def case_params
	    params.require(:case).permit(:number, :date_initiated, :date_decided, :recommended_outcome_id, :decided_outcome_id, defendant_attributes: [:first_name, :last_name, :rank_id, :number], case_rule_attributes:[:case_rule_id], case_rule_count_attributes:[:is_guilty]
	    )
	  end  
	end
end
