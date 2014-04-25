module UsersHelper
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
  def logged_in?
    !current_user.nil?
  end
  def admin_logged_in?
    if user = current_user
      user.admin
    end
  end
end
