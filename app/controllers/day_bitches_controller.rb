class DayBitchesController < ApplicationController
  before_filter :authenticate_admin, except: [:new, :create]
  before_filter :authenticate, only: [:new, :create]
  before_action :set_day_bitch, only: [:show, :edit, :update, :destroy]
  before_action :set_bitches_list_variable, only: [:edit, :new, :create]
  # GET /day_bitches
  # GET /day_bitches.json
  def index
    @day_bitches = DayBitch.all
  end

  # GET /day_bitches/1
  # GET /day_bitches/1.json
  def show
  end
  
  def thanks
    
  end

  # GET /day_bitches/new
  def new
    @day_bitch = DayBitch.new
  end

  # GET /day_bitches/1/edit
  def edit

  end

  # POST /day_bitches
  # POST /day_bitches.json
  def create
    @day_bitch = DayBitch.new(day_bitch_params)
    @day_bitch.date = Date.today
    @day_bitch.user = current_user
    
    today_user_bitches = DayBitch.where("date = :today AND user_id = :user", { today: Date.today, user: current_user } )

    if(today_user_bitches.count > 0)
      redirect_to :vote, alert: 'Můžete hlasovat pouze jednou denně.'
      return
    end

    if @day_bitch.save
      redirect_to :vote, notice: 'Váš hlas byl zaznamenán.'
    else
      redirect_to :root, alert: "Váš hlas se nepodařilo uložit."
    end
  end

  # PATCH/PUT /day_bitches/1
  # PATCH/PUT /day_bitches/1.json
  def update
    respond_to do |format|
      if @day_bitch.update(day_bitch_params)
        format.html { redirect_to @day_bitch, notice: 'Kurva dně byla úspěšně aktualizována.' }
        format.json { render :show, status: :ok, location: @day_bitch }
      else
        format.html { render :edit }
        format.json { render json: @day_bitch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /day_bitches/1
  # DELETE /day_bitches/1.json
  def destroy
    @day_bitch.destroy
    respond_to do |format|
      format.html { redirect_to day_bitches_url, notice: 'Day bitch was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_bitches_list_variable
    @bitches = Bitch.for_group(current_user.group)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_day_bitch
    @day_bitch = DayBitch.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def day_bitch_params
    params.require(:day_bitch).permit(:date, :bitch_id)
  end
end
