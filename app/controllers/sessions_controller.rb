class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email],
                                    params[:user][:password])
    if @user && @user.activated
      log_in_user!(user)

      redirect_to bands_url
    elsif @user && @user.inactive
      @user.errors[:base] << "Must be activated to log in. Go Check your email!"

      render :new
    else
      @user = User.new
      @user.errors[:base] << "Sorry, that username/password combo is invalid"
      
      render :new
    end
  end

  def destroy
    log_out(current_user)

    redirect_to new_session_url
  end

end
