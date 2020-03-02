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
      flash[:success] = "FPユーザを作成しました"
      redirect_to @fp_user
    else
      flash[:danger] = "FPユーザを作成できませんでした"
      render 'new'
    end
  end

  def show
    @fp_user = FpUser.find(params[:id])
    @reservations = Reservation.all.where(fp_user_id: @fp_user.id)
  rescue ActiveRecord::RecordNotFound => e
    redirect_to :root, alert: 'ユーザが見つかりませんでした'
  end

  def edit
    @fp_user = FpUser.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to :root, alert: 'ユーザが見つかりませんでした'
  end

  def update
    @fp_user = FpUser.find(params[:id])
    if @fp_user.update(fpuser_params)
      flash[:success] = "ユーザ情報を更新しました"
      redirect_to @fp_user
    else
      flash[:danger] = "ユーザ情報を更新できませんでした"
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
      flash[:danger] = "ログインしてください"
      redirect_to login_url
    end
  end
end
