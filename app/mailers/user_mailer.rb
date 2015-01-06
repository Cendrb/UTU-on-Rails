require 'securerandom'

class UserMailer < ActionMailer::Base
  default from: "utu@utu.com"
  def forgot_password(user)
    code = SecureRandom.hex
    user.forgot_password_code = code
    user.save!
    @user = user
    if Rails.env.development?
      @url = "http://localhost:3000/forgot_code?code=#{code}"
    else
      @url = "http://utu.herokuapp.com/forgot_code?code=#{code}"
    end
    mail(to: user.email, subject: "Změna hesla")
  end
end
