module Extranet
	class ApplicationController < ActionController::Base
	  layout 'admin'
	  before_filter :authenticate_user!
	  before_filter :authenticate_admin
	
	  def authenticate_admin
	   # TODO Add authentication logic here.
	  end
	end
end