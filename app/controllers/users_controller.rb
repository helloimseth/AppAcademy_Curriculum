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

      redirect_to new_user_url
    else
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password)
    end

end
