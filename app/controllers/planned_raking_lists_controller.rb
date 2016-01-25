class PlannedRakingListsController < ApplicationController
  before_action :set_planned_raking_list, only: [:show, :edit, :update, :destroy, :admin_show, :create_new_round]
  before_filter :authenticate_admin, except: [:show, :index]

  # GET /planned_raking_lists
  # GET /planned_raking_lists.json
  def index
    @data = {}

    @data[:planned_lists] = PlannedRakingList.where(sclass_id: current_class).where(planned: true)
    @data[:ordinary_lists] = PlannedRakingList.where(sclass_id: current_class).where(planned: false)
  end

  # GET /planned_raking_lists/1
  # GET /planned_raking_lists/1.json
  def show
    @data = {}
    @data[:list] = @planned_raking_list
    if params[:raking_round_number]
      @data[:round] = @planned_raking_list.raking_rounds.find_by_number(params[:raking_round_number].to_i)
    else
      @data[:round] = @planned_raking_list.current_round
    end
    @data[:admin] = false

    respond_to do |format|
      format.html { render "show.html.erb" }
      format.js { render "planned_raking_lists/show/remote_show" }
    end
  end

  def admin_show
    @data = {}
    @data[:list] = @planned_raking_list
    if params[:raking_round_number]
      @data[:round] = @planned_raking_list.raking_rounds.find_by_number(params[:raking_round_number].to_i)
    else
      @data[:round] = @planned_raking_list.current_round
    end
    @data[:admin] = true

    respond_to do |format|
      format.html { render "admin_show.html.erb" }
      format.js { render "planned_raking_lists/show/remote_show" }
    end
  end

  def create_new_round
    RakingRound.create!(number: @planned_raking_list.current_round.number + 1, planned_raking_list_id: @planned_raking_list.id, school_year: SchoolYear.current)
    redirect_to admin_show_planned_raking_lists_path(@planned_raking_list)
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
      params.require(:planned_raking_list).permit(:title, :description, :sclass_id, :subject_id, :beginning, :rekt_per_hour, :planned)
    end
end
