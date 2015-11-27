class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :detect_device_format
  before_action :set_locale
  before_action :troll
  layout :layout
  before_filter :set_current_account
  
  def set_current_account
    User.current = current_user
  end
  
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  private
    
    def layout
      if request.variant && request.variant.first == :mobile
        return "desktop_main"
      else
        return "desktop_main"
      end
    end
    
    def troll

    end
    
    def detect_device_format
      case request.user_agent
      when /iPad/i
        request.variant = :tablet
      when /iPhone/i
        request.variant = :mobile
      when /Android/i && /mobile/i
        request.variant = :mobile
      when /Android/i
        request.variant = :tablet
      when /Windows Phone/i
        request.variant = :mobile
      end
    end

  protected

  def next_workday
    date = Date.today
    begin
      date += 1.day
    end while(date.strftime("%A") == "Sunday" || date.strftime("%A") == "Saturday")
    return date
  end

  protected
  def authenticate_for_level(required_level)
    current = current_user
    if current && current.access_level >= required_level
      return true
    else
      if required_level == User.al_registered
        redirect_to :login, alert: 'Pro přístup do této sekce se musíte přihlásit'
      end
      if required_level == User.al_admin
        redirect_to utu_path, alert: 'Přístup do této sekce mají pouze administrátoři'
      end
      if required_level == User.al_superuser
        redirect_to utu_path, alert: 'Přístup do této sekce mají pouze správci systému'
      end
    end
  end

  def authenticate_superuser
    authenticate_for_level(User.al_superuser)
  end

  def authenticate_admin
    authenticate_for_level(User.al_admin)
  end

  def authenticate
    authenticate_for_level(User.al_registered)
  end

  def current_user
    begin
      if !session[:user_id].nil?
        User.find(session[:user_id])
      else if !cookies.signed[:user_id].nil?
          User.find(cookies.signed[:user_id])
        end
      end
    rescue Exception => e
      cookies.delete :user_id
      session[:user_id] = nil
      puts "Exception rescued! (#{e.message})"
    end
  end

  def logged_in?
    if current_user
    true
    else
    false
    end
  end

  def admin_logged_in?
    if current_user
      return current_user.access_for_level?(User.al_admin)
    end
  end

  def superuser_logged_in?
    if current_user
      return current_user.access_for_level?(User.al_superuser)
    end
  end

  helper_method :logged_in?, :current_user, :admin_logged_in?, :mobile_device?
end
