module Extranet
  class MinorityOpinionsController < Extranet::ApplicationController

    def create
      @minority_opinion = MinorityOpinion.new
      @minority_opinion.case_id = params[:case_id]
      @minority_opinion.save
      redirect_to :back
    end

    def destroy
      @minority_opinion = MinorityOpinion.find(params[:id])
      @minority_opinion.destroy
      redirect_to :back
    end

  end
end
