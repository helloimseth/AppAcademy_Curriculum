class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email],
                                     params[:user][:password])
    if @user
      log_in(@user)
      redirect_to subs_url
    else
      @user = User.new
      @user.email = params[:user][:email]
      flash.now[:error] = "Incorrect Credentials, could not find user. Dummy"

      render :new
    end

  end

  def destroy
    log_out(current_user)
    redirect_to new_session_url
  end

end
