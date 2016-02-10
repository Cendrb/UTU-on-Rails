class SclassesController < ApplicationController
  before_action :set_sclass, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_admin, except: [:change_current]
  skip_before_filter :current_class_check, only: [:change_current]

  # GET /sclasses
  # GET /sclasses.json
  def index
    @sclasses = Sclass.all
  end

  # GET /sclasses/1
  # GET /sclasses/1.json
  def show
  end

  # GET /sclasses/new
  def new
    @sclass = Sclass.new
  end

  # GET /sclasses/1/edit
  def edit
  end

  # POST /sclasses
  # POST /sclasses.json
  def create
    @sclass = Sclass.new(sclass_params)

    respond_to do |format|
      if @sclass.save
        format.html { redirect_to @sclass, notice: 'Sclass was successfully created.' }
        format.json { render :show, status: :created, location: @sclass }
      else
        format.html { render :new }
        format.json { render json: @sclass.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sclasses/1
  # PATCH/PUT /sclasses/1.json
  def update
    respond_to do |format|
      if @sclass.update(sclass_params)
        format.html { redirect_to @sclass, notice: 'Sclass was successfully updated.' }
        format.json { render :show, status: :ok, location: @sclass }
      else
        format.html { render :edit }
        format.json { render json: @sclass.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sclasses/1
  # DELETE /sclasses/1.json
  def destroy
    @sclass.destroy
    respond_to do |format|
      format.html { redirect_to sclasses_url, notice: 'Sclass was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def change_current
    session[:sclass_id] = params[:sclass_id]
    cookies.permanent[:sclass_id] = params[:sclass_id]
    render 'sclasses/current_class/current_class_changed'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sclass
      @sclass = Sclass.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sclass_params
      params.require(:sclass).permit(:name, :default_timetable_id)
    end
end
