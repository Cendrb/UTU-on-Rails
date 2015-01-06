require 'securerandom'

class UsersController < ApplicationController
  before_filter :authenticate_admin, only: :index
  before_action :set_user, only: [:show, :edit, :update, :destroy, :self_destroy]
  # GET /users
  # GET /users.json
  def index
    @users = User.order(:name)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to login_url, notice: 'Váš účet byl úspěšně vytvořen.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to administration_url, notice: 'Uživatel byl úspěšně aktualizován.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def self_destroy
    @user.destroy
    cookies.delete :user_id
    session[:user_id] = nil
    respond_to do |format|
      format.html { redirect_to login_url, notice: "Váš účet byl odstraněn" }
      format.json { head :no_content }
    end
  end

  def forgot_password_form

  end

  def forgot_password_send
    email = params[:email]
    user = User.find_by_email(email)
    if(user.nil?)
      redirect_to forgot_path, alert: "Žádný uživatel s danou emailovou adresou neexistuje"
    else
      UserMailer.forgot_password(user).deliver
    end
  end

  def forgot_password_code
    code = params[:code]
    puts code

    user = User.find_by_forgot_password_code(code)
    if(!user.nil?)
      user.forgot_password_code = SecureRandom.hex
      user.save!
      session[:user_id] = user.id
      redirect_to edit_user_path(user), notice: "Nyní jste dočasně přihlášeni a můžete se změnit své heslo"
    else
      redirect_to forgot_path, alert: "Použitý odkaz je neplatný"
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    if user = authenticate
      if user.id != params[:id].to_i && !user.admin
        redirect_to utu_path, alert: 'Nemáte práva měnit data jiných uživatelů'
      end
    end

    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :group, :name, :show_hidden_events, :show_hidden_exams, :show_hidden_tasks)
  end
end
