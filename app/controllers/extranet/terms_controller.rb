module Extranet
  class TermsController < Extranet::ApplicationController

    def create
      @term = Term.new
      @term.board_member_id = params[:board_member_id]
      if @term.save
        redirect_to :back
      end
    end

  end
end
