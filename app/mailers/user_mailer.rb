class UserMailer < ApplicationMailer
  default from: 'admin@test.com'

  def auth_email(user)
    @user = user
    @url = "localhost:3000/users/activate?activation_token=#{user.activation_token}"
    mail(to: user.email, subject: 'Activate Your Accunt at Music Inventory')
  end
end
