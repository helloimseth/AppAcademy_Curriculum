class UserMailer < ActionMailer::Base
  default from: "music@inventory.com"

  def activation_email(user)
    @user = user
    @url = "localhost:3000/users/activate?activation_token=#{user.activation_token}"
    mail(to: user.email, subject: "MusicInventory Account Activation")
  end
end
