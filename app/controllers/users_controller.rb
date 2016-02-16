class UsersController < ApplicationController
  before_filter :authenticate_admin!
  def new
	@user = User.new()
  end

  def show
    @user = User.find(params[:id])
  end
  
  def create
	@user = User.new(user_params)
    if @user.save
      redirect_to users, :notice => "User successfully added"
    else
      flash[:error] = "Oops, there was an error"
      render 'new'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    if @user.destroy
        redirect_to users_path, notice: "User deleted."
    end
  end
  
  def user_params
	params.require(:user).permit(:email, :password, :password_confirmation)
  end
end