class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :ensure_admin, only: [:index, :make_admin]

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

  def index
    @users = User.all.order(:id)
    render :index
  end

  def make_admin
    User.find(params[:user_id]).update(admin: true)
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end

  def ensure_admin
    unless current_user.admin == true
      flash[:error] = "Admin only!"
      redirect_to new_session_url
    end
  end

end
