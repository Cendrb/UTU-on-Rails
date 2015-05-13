class DetailsAccessesController < ApplicationController
  before_filter :authenticate_admin, except: [:analyze]
  before_action :set_details_access, only: [:show, :edit, :update, :destroy]

  # GET /details_accesses
  # GET /details_accesses.json
  def index
    @details_accesses = DetailsAccess.order("created_at DESC")
  end

  # GET /details_accesses/1
  # GET /details_accesses/1.json
  def show
  end

  # GET /details_accesses/new
  def new
    @details_access = DetailsAccess.new
  end

  # GET /details_accesses/1/edit
  def edit
  end

  # POST /details_accesses
  # POST /details_accesses.json
  def create
    @details_access = DetailsAccess.new(details_access_params)

    respond_to do |format|
      if @details_access.save
        format.html { redirect_to @details_access, notice: 'Details access was successfully created.' }
        format.json { render :show, status: :created, location: @details_access }
      else
        format.html { render :new }
        format.json { render json: @details_access.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /details_accesses/1
  # PATCH/PUT /details_accesses/1.json
  def update
    respond_to do |format|
      if @details_access.update(details_access_params)
        format.html { redirect_to @details_access, notice: 'Details access was successfully updated.' }
        format.json { render :show, status: :ok, location: @details_access }
      else
        format.html { render :edit }
        format.json { render json: @details_access.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /details_accesses/1
  # DELETE /details_accesses/1.json
  def destroy
    @details_access.destroy
    respond_to do |format|
      format.html { redirect_to details_accesses_url, notice: 'Details access was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def analyze
    @total = DetailsAccess.count
    @total_per_24_hours = DetailsAccess.where('created_at >= :date', date: 24.hours.ago).count
    @total_per_30_days = DetailsAccess.where('created_at >= :date', date: 24.days.ago).count
    @statistics_started = DetailsAccess.order('created_at asc').first.created_at
    
    accesses_count_hash = DetailsAccess.group_by_day(:created_at).count
    total = 0
    accesses_count_hash.each { |key, value| total += value }
    @average_per_day = total.to_f/accesses_count_hash.count.to_f
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_details_access
      @details_access = DetailsAccess.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def details_access_params
      params.require(:details_access).permit(:user_id, :ip_address, :user_agent)
    end
end
