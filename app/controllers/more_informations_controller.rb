class MoreInformationsController < ApplicationController
  before_action :set_more_information, only: [:show, :edit, :update, :destroy]

  # GET /more_informations
  # GET /more_informations.json
  def index
    @more_informations = MoreInformation.all
  end

  # GET /more_informations/1
  # GET /more_informations/1.json
  def show
  end

  # GET /more_informations/new
  def new
    @more_information = MoreInformation.new
  end

  # GET /more_informations/1/edit
  def edit
  end

  # POST /more_informations
  # POST /more_informations.json
  def create
    @more_information = MoreInformation.new(more_information_params)

    respond_to do |format|
      if @more_information.save
        format.html { redirect_to @more_information, notice: 'More information was successfully created.' }
        format.json { render action: 'show', status: :created, location: @more_information }
      else
        format.html { render action: 'new' }
        format.json { render json: @more_information.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /more_informations/1
  # PATCH/PUT /more_informations/1.json
  def update
    respond_to do |format|
      if @more_information.update(more_information_params)
        format.html { redirect_to @more_information, notice: 'More information was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @more_information.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /more_informations/1
  # DELETE /more_informations/1.json
  def destroy
    @more_information.destroy
    respond_to do |format|
      format.html { redirect_to more_informations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_more_information
      @more_information = MoreInformation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def more_information_params
      params.require(:more_information).permit(:name, :url)
    end
end
