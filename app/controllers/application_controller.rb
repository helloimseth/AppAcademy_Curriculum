class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def log_in(user)
    session[:token] = user.session_token
  end

  def log_out(user)
    session[:token] = nil
    user.reset_session_token!
  end

  def current_user
    return nil if session[:token].nil?
    User.find_by(session_token: session[:token])
  end
end
