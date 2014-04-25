class SessionsController < ApplicationController
  def new
  end

  def create
    if user = User.authenticate(params[:email], params[:password])
      if params[:permanent]
        cookies.signed[:user_id] = user.id
      end
      session[:user_id] = user.id
      if user.admin
        redirect_to administration_url
      else
        redirect_to utu_url
      end
    else
      redirect_to login_url, alert: "Neplatné jméno nebo heslo!"
    end
  end

  def destroy
    cookies.delete :user_id
    session[:user_id] = nil
    redirect_to login_url, notice: 'Uživatel byl odhlášen'
  end
end
