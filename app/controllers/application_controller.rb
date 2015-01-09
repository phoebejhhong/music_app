class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login

  helper_method :current_user, :logged_in?, :long_in_user!, :admin?

  def current_user
    user = User.find_by(session_token: session[:session_token])
    user ? user : nil
  end

  def logged_in?
    true if current_user
  end

  def log_in_user!(user)
    user.reset_session_token
    user.save!
    session[:session_token] = user.session_token
  end

  def admin?
    current_user.admin
  end

  private
  def require_login
    unless logged_in?
      flash[:error] = "You must log in first!"
      redirect_to new_session_url
    end
  end

end
