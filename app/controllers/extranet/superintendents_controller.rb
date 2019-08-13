module Extranet
    class SuperintendentsController < Extranet::ApplicationController
      def index
        @superintendents = Superintendent.all
      end

      def new
        @superintendent = Superintendent.new
      end

      def create
        @superintendent = Superintendent.new(superintendent_params)
        if @superintendent.save
            redirect_to extranet_superintendents_path, :notice => "Superintendent successfully added"
          else
            flash[:error] = "Oops, there was an error adding a new superintendent."
            render :action => 'new'
          end
      end

      def edit
        @superintendent = Superintendent.find(params[:id])
      end

      private
      def superintendent_params
        params.require(:superintendent).permit(:first_name, :last_name, :start_of_term, :end_of_term)
      end
    end
  end
  