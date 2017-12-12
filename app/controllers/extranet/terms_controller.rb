module Extranet
  class TermsController < Extranet::ApplicationController

    def create
      @term = Term.new
      @term.board_member_id = params[:board_member_id]
      @term.save
      redirect_to :back
    end

    def destroy
      @term = Term.find(params[:id])
      @term.destroy
      redirect_to :back
    end

  end
end
