class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in_user! (@user)
      redirect_to user_url
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end

end
