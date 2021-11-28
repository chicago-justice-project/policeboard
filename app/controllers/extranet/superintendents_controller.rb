module Extranet
    class SuperintendentsController < Extranet::ApplicationController
      before_action :populate_superintendent, only: [:edit, :update]

      def index
        @superintendents = Superintendent.order(start_of_term: :desc)
      end

      def new
        @superintendent = Superintendent.new
      end

      def create
        @superintendent = Superintendent.new(superintendent_params)
        if @superintendent.save
          redirect_to extranet_superintendents_path, :notice => "New superintendent successfully added"
        else
          flash[:alert] = "Oops, there was an error adding a new superintendent."
          render :action => 'new'
        end
      end

      def update
        if @superintendent.update(superintendent_params)
          redirect_to extranet_superintendents_path, :notice => "Superintendent successfully updated"
        else
          flash[:alert] = "Oops, there was an error updating superintendent information."
          render :action => 'edit'
        end
      end

      private
      def superintendent_params
        params.require(:superintendent).permit(:first_name, :last_name, :start_of_term, :end_of_term)
      end

      def populate_superintendent
        @superintendent = Superintendent.find(params[:id])
      end
    end
  end
  