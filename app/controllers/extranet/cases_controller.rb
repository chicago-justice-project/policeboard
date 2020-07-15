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
        #flash[:error] = "Oops there was an error."
        redirect_to new_extranet_case_path, :notice => "Oops there was an error saving this case. "
      end
    end

    def edit
      @case = Case.find(params[:id])
      @case.build_defendant if @case.defendant.nil?
      @rules = Rule.all
    end

    def update
      @case = Case.find(params[:id])
      @new_files = case_params[:files] || []

      set_case_files

      if @case.update_attributes(case_params)
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
      (Case.column_names + ["defendants.first_name", "outcomes.name"]).include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end

    def add_more_files(new_files)
      files = @case.files
      files += new_files
      @case_files = files
    end

    def set_case_files
      files = @case.files
      files += @new_files
      case_params[:files] = files

      @new_files.each do | file | CaseTextFile
                .create!(case_id: @case.id,
                         name: file.original_filename,
                         search_text:  pdf_to_text(file.tempfile))
      end
    end

    def pdf_to_text(file)
      reader = PDF::Reader.new(file)
      pdf_text = StringIO.new
      reader.pages.each do |page|
        pdf_text << page.text
        pdf_text << '\n' unless page.text.empty?
      end
      pdf_text.string
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
