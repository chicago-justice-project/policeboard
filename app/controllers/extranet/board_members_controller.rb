module Extranet
	class BoardMembersController < Extranet::ApplicationController
	  def index
	    @board_members = BoardMember.all
	  end
	  
	  def new
		@board_member = BoardMember.new
	  end
	  
	  def create
	  	@board_member = Board.new(board_member_params)
	  	if @board_member.save
	  		redirect_to extranet_board_members_path, :notice => "Board member successfully added"
	  	else
	  		flash[:error] = "Oops there was an error."
	  		render 'new'
	  	end
	  end
	  
	  def edit
	    @board_member = BoardMember.find(params[:id])
	  end
	  
	  def update
	    #render :text => @some_object.inspect
	    #raise case_params.inspect
	    #debug.inspect
	    
	  	@board_member = BoardMember.find(params[:id])
        #case_rules = params[:case].delete(:case_rules_attributes)

	  	#if @c.update_attributes(case_params)
	  	  #@c.update_attributes(:case_rules_attributes => case_rules)
	  	if @board_member.update_attributes(board_member_params)
		  	redirect_to extranet_board_members_path, :notice => "Case successfully updated"
	  	    #redirect_to extranet_case_path, :notice => "Case successfully updated"
	  	else
	  	  render :action => 'edit'	  	
	  	end
	  	
	  end
	  
	  def show
	    @board_member = Board.find(params[:id])
	  end
	  
	  def destroy
	  	@board_member = Case.find(params[:id])
	  	@board_member.destroy
	  	flash[:notice] = "Board member deleted"
	  	redirect_to extranet_board_members_path	  
	  end
	  
	  private
	  def board_member_params
	  	params.require(:board_member).permit(:first_name, :last_name, :job_title, :organization, 
	  		:facebook_handle, :twitter_handle, :linkedin_handle)
	    
	    #params.require(:board).permit! 
	  
	    #params.require(:case).permit(:number, :date_initiated, :date_decided, :recommended_outcome_id, :decided_outcome_id, 
	    #	defendant_attributes: [:first_name, :last_name, :rank_id, :number], 
	    #	:case_rules_attributes => [[:id, :_destroy]]
	    #)
	  end  
	end
end
