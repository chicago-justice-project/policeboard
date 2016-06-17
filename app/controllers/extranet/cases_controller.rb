module Extranet
	class CasesController < Extranet::ApplicationController
	  def index
	    @cases = Case.all
	  end
	  
	  def new
	  	@rules = Rule.all
	  	@case = Case.new
	  	@case.build_defendant
		1.times do
			case_rule = @case.case_rules.build
			board_member_vote = @case.board_member_votes.build
		end
	  end
	  
	  def create
	  	@case = Case.new(case_params)
	  	if @case.save
	  		redirect_to extranet_cases_path, :notice => "Case successfully added"
	  	else
	  		flash[:error] = "Oops there was an error."
	  		render 'new'
	  	end
	  end
	  
	  def edit
	    @case = Case.find(params[:id])
	    @rules = Rule.all
	  end
	  
	  def update
	    #:raise case_params[:files]
	    #board_member_votes = case_params[:board_member_votes]
	    #raise board_member_votes.inspect
	    #debug.inspect
	    
	    @c = Case.find(params[:id])
		new_files = case_params[:files]
	    #raise new_files.inspect
        if new_files.nil?
		  new_files = []
	    end

	    files = @c.files
            files += new_files
	    case_params[:files] = files
	   
	    if @c.update_attributes(case_params)
	      redirect_to extranet_cases_path, :notice => "Case successfully updated"
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
	  def add_more_files(new_files)
	    files = @case.files
	    files += new_files
            @case_files = files
	  end

	  def case_params
	    params.require(:case).permit! 
	  
	    #params.require(:case).permit(:number, :date_initiated, :date_decided, :recommended_outcome_id, :decided_outcome_id, 
	    #	defendant_attributes: [:first_name, :last_name, :rank_id, :number], 
	    #	:case_rules_attributes => [[:id, :_destroy]]
	    #)
	  end  
	end
end
