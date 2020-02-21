class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: session_params['email'])
    fpuser = Fpuser.find_by(email: session_params['email'])
    if user&.authenticate(session_params['password'])
      log_in user
      redirect_to user
    elsif fpuser&.authenticate(session_params['password'])
      log_in fpuser
      redirect_to fpuser
    else
      flash.now[:danger] = "Invalid email/password combination"
      render "new"
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end

