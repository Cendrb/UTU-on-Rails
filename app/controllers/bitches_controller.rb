class BitchesController < ApplicationController
  before_filter :authenticate_admin
  before_action :set_bitch, only: [:show, :edit, :update, :destroy]

  # GET /bitches
  # GET /bitches.json
  def index
    @bitches = Bitch.all
  end

  # GET /bitches/1
  # GET /bitches/1.json
  def show
  end

  # GET /bitches/new
  def new
    @bitch = Bitch.new
  end

  # GET /bitches/1/edit
  def edit
  end

  # POST /bitches
  # POST /bitches.json
  def create
    @bitch = Bitch.new(bitch_params)

    respond_to do |format|
      if @bitch.save
        format.html { redirect_to @bitch, notice: 'Bitch was successfully created.' }
        format.json { render :show, status: :created, location: @bitch }
      else
        format.html { render :new }
        format.json { render json: @bitch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bitches/1
  # PATCH/PUT /bitches/1.json
  def update
    respond_to do |format|
      if @bitch.update(bitch_params)
        format.html { redirect_to @bitch, notice: 'Bitch was successfully updated.' }
        format.json { render :show, status: :ok, location: @bitch }
      else
        format.html { render :edit }
        format.json { render json: @bitch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bitches/1
  # DELETE /bitches/1.json
  def destroy
    @bitch.destroy
    respond_to do |format|
      format.html { redirect_to bitches_url, notice: 'Bitch was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bitch
      @bitch = Bitch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bitch_params
      params.require(:bitch).permit(:name, :description, :group)
    end
end
