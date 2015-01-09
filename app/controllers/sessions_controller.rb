class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params[:email], user_params[:password])
    if @user.nil?
      @user = User.new(user_params)
      render :new
    else
      log_in_user!(@user)
      redirect_to bands_url
    end
  end

  def destroy
    current_user.reset_session_token
    current_user.save!
    session[:session_token] = nil
    redirect_to new_session_url
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end

end
