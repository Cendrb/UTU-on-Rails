class SgroupsController < ApplicationController
  before_action :set_sgroup, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_admin

  # GET /sgroups
  # GET /sgroups.json
  def index
    @sgroups = Sgroup.all
  end

  # GET /sgroups/1
  # GET /sgroups/1.json
  def show
  end

  # GET /sgroups/new
  def new
    @sgroup = Sgroup.new
  end

  # GET /sgroups/1/edit
  def edit
  end

  # POST /sgroups
  # POST /sgroups.json
  def create
    @sgroup = Sgroup.new(sgroup_params)

    respond_to do |format|
      if @sgroup.save
        format.html { redirect_to @sgroup, notice: 'Sgroup was successfully created.' }
        format.json { render :show, status: :created, location: @sgroup }
      else
        format.html { render :new }
        format.json { render json: @sgroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sgroups/1
  # PATCH/PUT /sgroups/1.json
  def update
    respond_to do |format|
      if @sgroup.update(sgroup_params)
        format.html { redirect_to @sgroup, notice: 'Sgroup was successfully updated.' }
        format.json { render :show, status: :ok, location: @sgroup }
      else
        format.html { render :edit }
        format.json { render json: @sgroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sgroups/1
  # DELETE /sgroups/1.json
  def destroy
    @sgroup.destroy
    respond_to do |format|
      format.html { redirect_to sgroups_url, notice: 'Sgroup was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sgroup
      @sgroup = Sgroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sgroup_params
      params.require(:sgroup).permit(:name, :group_category_id, :timetable_abbr)
    end
end
