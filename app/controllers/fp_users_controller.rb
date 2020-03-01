class FpUsersController < ApplicationController
  before_action :require_login, only: %i(show)
  before_action :correct_fp_user, only: %i(edit update)

  def new
    @fp_user = FpUser.new
  end

  def create
    @fp_user = FpUser.new(fpuser_params)
    if @fp_user.save
      log_in @fp_user
      redirect_to @fp_user
    else
      render 'new'
    end
  end

  def show
    @fp_user = FpUser.find(params[:id])
    @reservations = Reservation.all.where(fp_user_id: current_user.id)
  rescue ActiveRecord::RecordNotFound => e
    redirect_to :root, alert: 'User not found'
  end

  def edit
    @fp_user = FpUser.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to :root, alert: 'User not found'
  end

  def update
    @fp_user = FpUser.find(params[:id])
    if @fp_user.update(fpuser_params)
      redirect_to @fp_user
    else
      render 'edit'
    end
  end

  private

  def fpuser_params
    params.require(:fp_user).permit(:name, :email, :password, :password_confirmation, :introduction)
  end

  def correct_fp_user
    @fp_user = FpUser.find(params[:id])
    redirect_to(root_url) unless current_user == @fp_user
  end

  def require_login
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
