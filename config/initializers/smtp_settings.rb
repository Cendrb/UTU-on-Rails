ActionMailer::Base.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    domain: 'smtp.gmail.com',
    user_name: ENV['email_user_name'],
    password: ENV['email_password'],
    authentication: :login,
    enable_starttls_auto: true
}