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
      if UserAgent.parse(request.env['HTTP_USER_AGENT']).browser == "Internet Explorer"
        redirect_to "http://explorer.je.sračka.homo.com"
      end
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

  def authenticate_admin
    if current_user && current_user.admin
    return true
    else
      redirect_to utu_path, alert: 'Nemáte dostatečná oprávnění pro přístup do této sekce'
    end
  end

  def authenticate
    if user = current_user
    user
    else
      redirect_to login_url
    end
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
    if user = current_user
    user.admin
    end
  end

  helper_method :logged_in?, :current_user, :admin_logged_in?, :mobile_device?
end
