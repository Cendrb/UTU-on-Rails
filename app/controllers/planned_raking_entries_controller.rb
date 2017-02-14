class PlannedRakingEntriesController < ApplicationController
  before_action :set_planned_raking_entry, only: [:show, :edit, :update, :destroy, :mark_as_rekt]
  before_action :authenticate, only: [:new_planned_rekt, :create]
  before_action :authenticate_admin, except: [:new_planned_rekt, :create]

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
    if params[:id]
      set_planned_raking_entry()
    else
      @planned_raking_entry = PlannedRakingEntry.new
      @planned_raking_entry.planned_raking_list_id = params[:list_id] if params[:list_id]
      @planned_raking_entry.class_member_id = current_user.class_member_id if current_user
      @planned_raking_entry.finished = true
    end

    render 'planned_raking_entries/new_already_rekt'
  end

  def new_planned_rekt
    @planned_raking_entry = PlannedRakingEntry.new
    @planned_raking_entry.planned_raking_list_id = params[:list_id] if params[:list_id]
    @planned_raking_entry.class_member_id = current_user.class_member_id if current_user
    render 'planned_raking_entries/new_planned_rekt'
  end

  def sort # called when swapping items in the list
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

  # POST /planned_raking_entries
  # POST /planned_raking_entries.json
  def create
    @planned_raking_entry = PlannedRakingEntry.new(planned_raking_entry_params)

    if admin_logged_in?
      # keep class_member value as set from params
      unless @planned_raking_entry.class_member
        @planned_raking_entry.class_member = current_user.class_member
      end
    else
      # set to current_user
      @planned_raking_entry.class_member = current_user.class_member
    end

    unless @planned_raking_entry.raking_round
      @planned_raking_entry.raking_round = @planned_raking_entry.planned_raking_list.current_round
    end

    already_rekt = false
    if @planned_raking_entry.finished
      already_rekt = true
    else
      @planned_raking_entry.finished = false
    end

    already_existing_entry = PlannedRakingEntry.where(planned_raking_list: @planned_raking_entry.planned_raking_list,
                                                      raking_round: @planned_raking_entry.raking_round,
                                                      class_member: @planned_raking_entry.class_member).first

    if already_existing_entry
      if already_existing_entry.finished && !@planned_raking_entry.finished
        # disallow 'unrekt'
        redirect_to @planned_raking_entry.planned_raking_list, alert: 'Už jste byl jednou vyzkoušen a podruhé se do tohoto kola přihlásit nemůžete'
        return
      end
      marked_as_rekt = !already_existing_entry.finished && @planned_raking_entry.finished
      already_existing_entry.description = @planned_raking_entry.description
      already_existing_entry.finished = @planned_raking_entry.finished
      already_existing_entry.grade = @planned_raking_entry.grade
      @planned_raking_entry = already_existing_entry
    else
      maximum_sorting_order = PlannedRakingEntry.where(planned_raking_list: @planned_raking_entry.planned_raking_list).maximum(:sorting_order)
      maximum_sorting_order = 0 unless maximum_sorting_order
      @planned_raking_entry.sorting_order = maximum_sorting_order + 1
    end


    respond_to do |format|
      if @planned_raking_entry.save
        format.html {
          if @planned_raking_entry.finished
            if already_existing_entry
              if marked_as_rekt
                redirect_to @planned_raking_entry.planned_raking_list, notice: @planned_raking_entry.class_member.full_name + ' vyzkoušen se známkou ' + @planned_raking_entry.grade
              else
                redirect_to @planned_raking_entry.planned_raking_list, notice: 'Upraven záznam ' + @planned_raking_entry.class_member.full_name + ' (známka ' + @planned_raking_entry.grade + ')'
              end
            else
              redirect_to @planned_raking_entry.planned_raking_list, notice: @planned_raking_entry.class_member.full_name + ' vyzkoušen se známkou ' + @planned_raking_entry.grade
            end
          else
            if already_existing_entry
              redirect_to @planned_raking_entry.planned_raking_list, notice: 'V tomto seznamu jste již přihlášeni.'
            else
              redirect_to @planned_raking_entry.planned_raking_list, notice: 'Přihlášení proběhlo úspěšně'
            end
          end
        }
        format.json { render :show, status: :created, location: @planned_raking_entry }
      else
        format.html {
          if already_rekt
            render :new_already_rekt
          else
            render :new_planned_rekt
          end }
        format.json { render json: @planned_raking_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /planned_raking_entries/1
  # DELETE /planned_raking_entries/1.json
  def destroy
    path_to_go = admin_show_planned_raking_lists_path(@planned_raking_entry.planned_raking_list)
    @planned_raking_entry.destroy
    respond_to do |format|
      format.html { redirect_to path_to_go, notice: @planned_raking_entry.class_member.full_name + ' úspěšně vyhlazen/a' }
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
    params.require(:planned_raking_entry).permit(:planned_raking_list_id, :class_member_id, :description, :finished, :grade, :raking_round_id)
  end
end
