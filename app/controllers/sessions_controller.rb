class SessionsController < ApplicationController
  def new; end

  def create
    if ActiveRecord::Type::Boolean.new.cast(session_params[:check_fp])
      user = FpUser.find_by(email: session_params[:email])
    else
      user = User.find_by(email: session_params[:email])
    end
    if user&.authenticate(session_params[:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = "メールアドレスまたはパスワードに誤りがあります"
      render "new"
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def session_params
    params.require(:session).permit(:email, :password, :check_fp)
  end
end

