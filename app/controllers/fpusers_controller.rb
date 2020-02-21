class FpusersController < ApplicationController
  before_action :logged_in_user, except: :new

  def new
    @fpuser = Fpuser.new
  end

  def create
    @fpuser = Fpuser.new(fpuser_params)
    if @fpuser.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @fpuser = Fpuser.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to :root, alert: 'User not found'
  end

  private
  def fpuser_params
    params.require(:fpuser).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
