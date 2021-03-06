class EventsController < ApplicationController
  include GenericUtuItems
  before_filter :authenticate_admin, except: [:show]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.order("event_start DESC").limit(30)
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
    new_init(@event)
  end

  # GET /events/1/edit
  def edit
    edit_init(@event)
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    update_init(@event)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    update_init(@event)
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
    end
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
      format.js
      format.whoa { render plain: "WHOA" }
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:title, :description, :location, :event_start, :event_end, :sgroup_id, :sclass_id, :price, :pay_date)
  end
end
