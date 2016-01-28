class PlannedRakingEntriesController < ApplicationController
  before_action :set_planned_raking_entry, only: [:show, :edit, :update, :destroy, :mark_as_rekt]
  before_filter :authenticate_admin, except: [:new_planned_rekt, :create]

  # GET /planned_raking_entries
  # GET /planned_raking_entries.json
  def index
    @planned_raking_entries = PlannedRakingEntry.order(:sorting_order).all
  end

  # GET /planned_raking_entries/1
  # GET /planned_raking_entries/1.json
  def show
  end

  def new_already_rekt
    @planned_raking_entry = PlannedRakingEntry.new
    @planned_raking_entry.planned_raking_list_id = params[:list_id] if params[:list_id]
    @planned_raking_entry.class_member_id = current_user.class_member_id if current_user
    @planned_raking_entry.finished = true
    render 'planned_raking_entries/new_already_rekt'
  end

  def new_planned_rekt
    @planned_raking_entry = PlannedRakingEntry.new
    @planned_raking_entry.planned_raking_list_id = params[:list_id] if params[:list_id]
    @planned_raking_entry.class_member_id = current_user.class_member_id if current_user
    render 'planned_raking_entries/new_planned_rekt'
  end

  # GET /planned_raking_entries/1/edit
  def edit
  end

  def sort
    array = params[:data]
    puts array
    array.each do |pair|
      puts pair
      entry = PlannedRakingEntry.find(pair.last.last)
      entry.sorting_order = pair.last.first
      entry.save
    end
    render nothing: true
  end

  def mark_as_rekt
    @planned_raking_entry.finished = true
    @planned_raking_entry.save!
  end

  # POST /planned_raking_entries
  # POST /planned_raking_entries.json
  def create
    @planned_raking_entry = PlannedRakingEntry.new(planned_raking_entry_params)
    @planned_raking_entry.raking_round = @planned_raking_entry.planned_raking_list.current_round
        already_rekt = false
    if @planned_raking_entry.finished
      already_rekt = true
    else
      @planned_raking_entry.finished = false
    end
    maximum_sorting_order = PlannedRakingEntry.where(planned_raking_list: @planned_raking_entry.planned_raking_list).maximum(:sorting_order)
    maximum_sorting_order = 0 unless maximum_sorting_order
    @planned_raking_entry.sorting_order = maximum_sorting_order + 1

    respond_to do |format|
      if @planned_raking_entry.save
        format.html { redirect_to @planned_raking_entry.planned_raking_list, notice: 'Přihlášení proběhlo úspěšně' }
        format.json { render :show, status: :created, location: @planned_raking_entry }
      else
        format.html { if already_rekt
                        render :new_already_rekt
                      else
                        render :new_planned_rekt
                      end }
        format.json { render json: @planned_raking_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /planned_raking_entries/1
  # PATCH/PUT /planned_raking_entries/1.json
  def update
    respond_to do |format|
      if @planned_raking_entry.update(planned_raking_entry_params)
        format.html { redirect_to @planned_raking_entry, notice: 'Planned raking entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @planned_raking_entry }
      else
        format.html { render :edit }
        format.json { render json: @planned_raking_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /planned_raking_entries/1
  # DELETE /planned_raking_entries/1.json
  def destroy
    @planned_raking_entry.destroy
    respond_to do |format|
      format.html { redirect_to planned_raking_entries_url, notice: 'Planned raking entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_planned_raking_entry
    @planned_raking_entry = PlannedRakingEntry.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def planned_raking_entry_params
    params.require(:planned_raking_entry).permit(:planned_raking_list_id, :class_member_id, :description, :finished, :grade)
  end
end
