class UsersController < ApplicationController
  before_action :require_login, only: %i(show)
  before_action :correct_user, only: %i(edit update)

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @reservations = Reservation.all.where(user_id: current_user.id)
  rescue ActiveRecord::RecordNotFound => e
    redirect_to :root, alert: 'User not found'
  end

  def edit
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to :root, alert: 'User not found'
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user == @user
  end

  def require_login
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
