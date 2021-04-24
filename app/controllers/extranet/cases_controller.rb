module Extranet
  class CasesController < Extranet::ApplicationController
    helper_method :sort_column, :sort_direction

    def index
      @cases = Case.includes(:defendant, :recommended_outcome, :decided_outcome).order(sort_column + " " + sort_direction)

      respond_to do |format|
        format.html
        format.csv do
          headers['Content-Disposition'] = "attachment; filename=\"case-list.csv\""
          headers['Content-Type'] ||= 'text/csv'
        end
      end
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
        error_message = @case.errors.full_messages
        Rails.logger.error error_message
        #flash[:error] = "Oops there was an error."
        redirect_to new_extranet_case_path, :alert => "Oops there was an error saving this case. "
      end
    end

    def edit
      @case = Case.find(params[:id])
      @activeMembersAtTime = getActiveBoardMembersAtTime

      @case.build_defendant if @case.defendant.nil?
      @rules = Rule.all
    end

    def getActiveBoardMembersAtTime 
        allBoardMembers = BoardMember.all.sort_by{ |b| b.last_name }
        activeBoardMembers = []
        allBoardMembers.each do | boardMember |
            boardMember.terms.each do | term |
                if @case.date_decided >= term.start
                    if term.end && @case.date_decided <= term.end
                        puts "added board member #{boardMember.id}"
                        activeBoardMembers.push(boardMember)
                    end
                end
            end
        end
        return activeBoardMembers
    end


    def update
      @c = Case.find(params[:id])
      new_files = case_params[:files]

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
    def sort_column
      (Case.column_names + ["defendants.first_name", "outcomes.name"]).include?(params[:sort]) ? params[:sort] : "number"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end

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
