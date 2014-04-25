module UsersHelper
  def current_user
    if !session[:user_id].nil?
      User.find(session[:user_id])
    end
  end
  def logged_in?
    !current_user.nil?
  end
  def admin_logged_in?
    if user = current_user
      user.admin
    end
  end
end
