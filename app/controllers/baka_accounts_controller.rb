class BakaAccountsController < ApplicationController
  before_action :set_baka_account, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_admin

  # GET /baka_accounts
  # GET /baka_accounts.json
  def index
    @baka_accounts = BakaAccount.all
  end

  # GET /baka_accounts/1
  # GET /baka_accounts/1.json
  def show
  end

  # GET /baka_accounts/new
  def new
    @baka_account = BakaAccount.new
  end

  # GET /baka_accounts/1/edit
  def edit
  end

  # POST /baka_accounts
  # POST /baka_accounts.json
  def create
    @baka_account = BakaAccount.new(baka_account_params)

    respond_to do |format|
      if @baka_account.save
        format.html { redirect_to @baka_account, notice: 'Baka account was successfully created.' }
        format.json { render :show, status: :created, location: @baka_account }
      else
        format.html { render :new }
        format.json { render json: @baka_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /baka_accounts/1
  # PATCH/PUT /baka_accounts/1.json
  def update
    respond_to do |format|
      if @baka_account.update(baka_account_params)
        format.html { redirect_to @baka_account, notice: 'Baka account was successfully updated.' }
        format.json { render :show, status: :ok, location: @baka_account }
      else
        format.html { render :edit }
        format.json { render json: @baka_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /baka_accounts/1
  # DELETE /baka_accounts/1.json
  def destroy
    @baka_account.destroy
    respond_to do |format|
      format.html { redirect_to baka_accounts_url, notice: 'Baka account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_baka_account
      @baka_account = BakaAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def baka_account_params
      params.require(:baka_account).permit(:username, :password, :name)
    end
end
