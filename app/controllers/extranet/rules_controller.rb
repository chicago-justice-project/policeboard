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
	  end
	
	  def edit
		@rule = Rule.find(params[:id])
	  end
	
	  def update
	  end
	
	  def show
	  end
	
	  def destroy
	  end
	end
end

