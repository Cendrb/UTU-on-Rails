require 'securerandom'

class UserMailer < ActionMailer::Base
  default from: "UTU"
  
  def forgot_password(user)
    code = SecureRandom.hex
    user.forgot_password_code = code
    user.save!
    @user = user
    @url = "http://localhost:3000/forgot_code?code=#{code}"
    mail(to: user.email, subject: "Změna hesla")
  end
end
