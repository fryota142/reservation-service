class FpUsersController < ApplicationController
  before_action :require_login, only: %i(show)

  def new
    @fp_user = FpUser.new
  end

  def create
    @fp_user = FpUser.new(fpuser_params)
    if @fp_user.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @fp_user = FpUser.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to :root, alert: 'User not found'
  end

  private
  def fpuser_params
    params.require(:fp_user).permit(:name, :email, :password, :password_confirmation)
  end

  def require_login
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
