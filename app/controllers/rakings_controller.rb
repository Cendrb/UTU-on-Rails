class RakingsController < ApplicationController
  before_filter :authenticate_admin, except: [:show]
  before_action :set_raking, only: [:show, :edit, :update, :destroy]

  # GET /rakings
  # GET /rakings.json
  def index
    @rakings = Raking.all
  end

  # GET /rakings/1
  # GET /rakings/1.json
  def show
  end

  # GET /rakings/new
  def new
    @raking = Raking.new
  end

  # GET /rakings/1/edit
  def edit
  end

  # POST /rakings
  # POST /rakings.json
  def create
    @raking = Raking.new(raking_params)

    respond_to do |format|
      if @raking.save
        format.html { redirect_to @raking, notice: 'Raking was successfully created.' }
        format.json { render :show, status: :created, location: @raking }
      else
        format.html { render :new }
        format.json { render json: @raking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rakings/1
  # PATCH/PUT /rakings/1.json
  def update
    respond_to do |format|
      if @raking.update(raking_params)
        format.html { redirect_to @raking, notice: 'Raking was successfully updated.' }
        format.json { render :show, status: :ok, location: @raking }
      else
        format.html { render :edit }
        format.json { render json: @raking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rakings/1
  # DELETE /rakings/1.json
  def destroy
    @raking.destroy
    respond_to do |format|
      format.html { redirect_to rakings_url, notice: 'Raking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_raking
      @raking = Raking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def raking_params
      params.require(:raking).permit(:end, :subject_id, :name, :description)
    end
end
