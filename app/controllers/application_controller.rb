class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  protected

  def authenticate_admin
    if authenticate.admin
    return true
    else
      redirect_to utu_path, alert: 'Nemáte dostatečná oprávnění pro přístup do této sekce'
    end
  end

  protected

  def authenticate
    if user = current_user
    user
    else
      redirect_to login_url
    end
  end

  private

  def current_user
    begin
      if !session[:user_id].nil?
        User.find(session[:user_id])
      else if !cookies.signed[:user_id].nil?
          User.find(session[:user_id])
        end
      end
    rescue Exception => e
      cookies.delete :user_id
      session[:user_id] = nil
      puts "Exception rescued! (#{e.message})"
    end
  end
end
