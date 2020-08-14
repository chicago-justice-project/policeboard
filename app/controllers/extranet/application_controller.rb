module Extranet
  class ApplicationController < ActionController::Base
    layout 'admin'
    before_action :authenticate_user!
    before_action :authenticate_admin

    def authenticate_admin
     # TODO Add authentication logic here.
    end
  end
end
