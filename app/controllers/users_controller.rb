class UsersController < ApplicationController
  def new
  end

  def show
    @user = User.find_by_email(params[:id])
	authorize @user
  end
end