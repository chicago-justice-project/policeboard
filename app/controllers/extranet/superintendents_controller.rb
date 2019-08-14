module Extranet
    class SuperintendentsController < Extranet::ApplicationController
      def index
        @superintendents = Superintendent.order(start_of_term: :desc)
      end

      def new
        @superintendent = Superintendent.new
      end

      def create
        @superintendent = Superintendent.new(superintendent_params)
        if @superintendent.save
          # TO DO : the "notice" section does not look good, and is not noticable. do some css work for this 
          redirect_to extranet_superintendents_path, :notice => "Superintendent successfully added"
        else
          # TO DO : flash[:error] does not work, implement some other error display
          # flash[:error] = "Oops, there was an error adding a new superintendent."
          render :action => 'new'
        end
      end

      def edit
        @superintendent = Superintendent.find(params[:id])
      end

      def update
        @superintendent = Superintendent.find(params[:id])
        if @superintendent.update_attributes(superintendent_params)
          redirect_to extranet_superintendents_path, :notice => "Superintendent successfully added"
        else
          # TO DO : implement error display
          render :action => 'edit'
        end
      end

      private
      def superintendent_params
        params.require(:superintendent).permit(:first_name, :last_name, :start_of_term, :end_of_term)
      end
    end
  end
  