class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "We've sent an activation email to your account. Please
                        click the link in the body of the email to activate
                        your acount."

      @user.generate_activation_token!
      msg = UserMailer.activation_email(@user)
      msg.deliver

      redirect_to new_user_url
    else
      render :new
    end
  end

  def activate
    @user = User.find_by(activation_token: params[:activation_token])
    @user.toggle(:activated)
    log_in(@user)

    flash[:notice] = "Welcome, #{@user.email}!"

    redirect_to bands_url
  end

  private

    def user_params
      params.require(:user).permit(:email, :password)
    end

end
