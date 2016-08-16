class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :current_class_check

  def new
  end

  def create
    if user = User.authenticate(params[:email], params[:password])
      if params[:permanent]
        cookies.permanent.signed[:user_id] = user.id
      end
      session[:user_id] = user.id

      @user = user

      respond_to do |format|
        format.html {
          if admin_logged_in?
            redirect_to administration_url
          else
            redirect_to utu_url
          end }
        format.whoa { render plain: GenericUtuItem.success_string }
        format.xml { render 'sessions/create.xml.builder' }
      end

    else
      respond_to do |format|
        format.html { redirect_to login_url, alert: "Neplatné jméno nebo heslo!" }
        format.xml { render plain: GenericUtuItem.failure_string }
        format.whoa { render plain: GenericUtuItem.failure_string }
      end
    end
  end

  def destroy
    cookies.delete :user_id
    session[:user_id] = nil
    redirect_to login_url, notice: 'Uživatel byl odhlášen'
  end
end
