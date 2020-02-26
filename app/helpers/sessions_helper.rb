module SessionsHelper
  def log_in(user)
    if user.class == User
      session[:user_id] = user.id
    elsif user.class == FpUser
      session[:fp_user_id] = user.id
    end
  end

  def current_user
    if session[:user_id].present?
      @current_user = User.find_by(id: session[:user_id])
    elsif session[:fp_user_id].present?
      @current_user = FpUser.find_by(id: session[:fp_user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    session.delete(:fp_user_id)
    @current_user = nil
  end
end
