class RegistrationsController < Devise::RegistrationsController

  before_action :one_user_registered?

  protected

  def one_user_registered?
    if ((User.count == 1) & (user_signed_in?))
       redirect_to root_path
    elsif User.count == 1
       redirect_to new_user_session_path
    end
  end
end
