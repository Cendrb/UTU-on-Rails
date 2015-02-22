class EventsController < ApplicationController
  before_filter :authenticate_admin, except: [:hide, :reveal, :snooze, :unsnooze]
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_event_from_event_id, only: [:hide, :reveal, :snooze, :unsnooze]
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy, :hide, :reveal, :snooze, :unsnooze]
  # GET /events
  # GET /events.json
  def index
    @events = Event.order("event_start DESC")
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
    @event.pay_date = next_workday
    @event.event_start = next_workday
    @event.event_end = next_workday
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
        format.whoa { render plain: 'success' }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
        format.whoa { render plain: 'fail' }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
        format.whoa { render plain: 'success' }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
        format.whoa { render plain: 'fail' }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
      format.whoa { render plain: 'success' }
    end
  end

  def hide
     @event.mark_as_done
    
    redirect_back
  end

  def reveal
    @event.mark_as_undone

    redirect_back
  end
  
  def snooze
     @event.snooze(params[:date])
    
    redirect_back
  end

  def unsnooze
    @event.unsnooze

    redirect_back
  end

  private
  
  def redirect_html_back
    if request.env['HTTP_REFERER']
      redirect_to :back
    else
      redirect_to details_path
    end
  end
  
  def redirect_back
    respond_to do |format|
      format.html { redirect_html_back }
      format.whoa { render plain: "WHOA" }
    end
    if request.env['HTTP_REFERER']
      redirect_to :back
    else
      redirect_to details_path
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  def set_event_from_event_id
    @event = Event.find(params[:event_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:title, :description, :location, :event_start, :event_end, :additional_info_url, :price, :pay_date)
  end
end
