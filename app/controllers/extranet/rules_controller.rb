module Extranet
  class RulesController < Extranet::ApplicationController
    def index
      @rules = Rule.all
      @rules.inspect
    end

    def new
      @rule = Rule.new
    end

    def create
      @rule = Rule.create
      if @rule.save
        redirect_to extranet_rules_path, :notice => "Rule successfully added"
      else
        flash[:error] = "Oops, there was an error creating a new rule."
        render :action => 'new'
      end
    end

    def edit
      @rule = Rule.find(params[:id])
    end

    def update
      @rule = Rule.find(params[:id])
      if @rule.update(rule_params)
        redirect_to extranet_rules_path, :notice => "rule successfully saved"
      else
        render :action => 'edit'
      end
    end

    def show
    end

    def destroy
      @rule = Rule.find(params[:id])
      @rule.destroy
      flash[:notice] = "Rule deleted"
      redirect_to extranet_rules_path
    end

    private
    def rule_params
      params.require(:rule).permit(:code, :description, :comment)
      #params.require(:case).permit(:number, :date_initiated, :date_decided, :recommended_outcome_id, :decided_outcome_id,
      #	defendant_attributes: [:first_name, :last_name, :rank_id, :number],
      #	:case_rules_attributes => [[:id, :_destroy]]
      #)
      end
  end
end
