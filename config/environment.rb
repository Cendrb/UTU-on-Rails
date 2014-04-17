# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
UTUOnRails::Application.initialize!

# Mail config
UTUOnRails::Application.configure do
  config.action_mailer.delivery_method = :smtp
  
  config.action_mailer.smatp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    user_name: adisinfoapp,
    password: "suprakindrlo",
    enable_starttls_auto: true
  }
end
