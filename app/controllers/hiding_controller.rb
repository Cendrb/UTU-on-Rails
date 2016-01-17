class HidingController < ApplicationController
  before_filter :authenticate

  def hide
    id = params[:id]
    @type = params[:type]
    if @type == 'event'
      # event
      @item = Event.find(id)
    else
      if @type == 'task'
        # task
        @item = Task.find(id)
      else
        # exam
        @item = Exam.find(id)
      end
    end

    @item.mark_as_done
  end

  def reveal
    id = params[:id]
    @type = params[:type]
    if @type == 'event'
      # event
      @item = Event.find(id)
    else
      if @type == 'task'
        # task
        @item = Task.find(id)
      else
        @item = Exam.find(id)
      end
    end

    @item.mark_as_undone
  end
end