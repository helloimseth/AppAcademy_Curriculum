class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  private

  def log_in(user)
    session[:token] = user.session_token
  end

  def log_out(user)
    session[:token] = nil
    user.reset_session_token!
  end

  def current_user
    User.find_by(session_token: session[:token])
  end

  def logged_in?
    !!current_user
  end

  def log_in_user!(user)
    user.reset_session_token!
    log_in(user)
  end

  def ensure_logged_in
    redirect_to new_session_url unless logged_in?
  end
end
