module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    user.remember
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (remember_token = cookies[:remember_token])
      user = User.find_by(remember_digest: Digest::SHA1.hexdigest(remember_token.to_s))
      if user
        log_in user
        @current_user = user
      end
    end
  end

  def log_out
    session[:user_id] = nil
    cookies.delete(:remember_token)
  end

  def logged_in?
    !current_user.nil?
  end
end
