class PlannedRakingListsController < ApplicationController
  before_action :set_planned_raking_list, only: [:show, :edit, :update, :destroy, :admin_show]
  before_filter :authenticate_admin, except: [:show, :index]

  # GET /planned_raking_lists
  # GET /planned_raking_lists.json
  def index
    @planned_raking_lists = PlannedRakingList.all.order(:sclass_id)
  end

  # GET /planned_raking_lists/1
  # GET /planned_raking_lists/1.json
  def show
    @data = {}
    @data[:list] = @planned_raking_list
    @data[:entries] = @planned_raking_list.planned_raking_entries.where(finished: false).order(:sorting_order)
  end

  def admin_show
    @data = {}
    @data[:list] = @planned_raking_list
    @data[:entries] = @planned_raking_list.planned_raking_entries.order(:finished, :sorting_order)
  end

  # GET /planned_raking_lists/new
  def new
    @planned_raking_list = PlannedRakingList.new
  end

  # GET /planned_raking_lists/1/edit
  def edit
  end

  # POST /planned_raking_lists
  # POST /planned_raking_lists.json
  def create
    @planned_raking_list = PlannedRakingList.new(planned_raking_list_params)

    respond_to do |format|
      if @planned_raking_list.save
        format.html { redirect_to @planned_raking_list, notice: 'Planned raking list was successfully created.' }
        format.json { render :show, status: :created, location: @planned_raking_list }
      else
        format.html { render :new }
        format.json { render json: @planned_raking_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /planned_raking_lists/1
  # PATCH/PUT /planned_raking_lists/1.json
  def update
    respond_to do |format|
      if @planned_raking_list.update(planned_raking_list_params)
        format.html { redirect_to @planned_raking_list, notice: 'Planned raking list was successfully updated.' }
        format.json { render :show, status: :ok, location: @planned_raking_list }
      else
        format.html { render :edit }
        format.json { render json: @planned_raking_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /planned_raking_lists/1
  # DELETE /planned_raking_lists/1.json
  def destroy
    @planned_raking_list.destroy
    respond_to do |format|
      format.html { redirect_to planned_raking_lists_url, notice: 'Planned raking list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_planned_raking_list
      @planned_raking_list = PlannedRakingList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def planned_raking_list_params
      params.require(:planned_raking_list).permit(:title, :description, :sclass_id, :subject_id, :beginning, :rekt_per_hour)
    end
end
