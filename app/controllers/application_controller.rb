class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :check_admin

  def ensure_that_signed_in
    redirect_to signin_path, notice: 'you should be signed in' if current_user.nil?
  end

  def current_user
    return nil if session[:user_id].nil?

    User.find(session[:user_id])
  end

  def check_admin
    redirect_to root_path, notice: 'action not allowed' unless current_user&.admin
  end
end
