class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by_credentials(params[:user][:email],
                                    params[:user][:password])
    if user
      user.reset_session_token!
      log_in(user)

      redirect_to user_url(user)
    else
      render :new
    end
  end

end
