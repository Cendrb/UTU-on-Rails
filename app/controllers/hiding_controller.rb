class HidingController < ApplicationController
  before_filter :authenticate

  def hide
    id = params[:id]
    @type = params[:type]
    if @type == 'event'
      @item = Event.find(id)
    end
    if @type == 'task'
      @item = Task.find(id)
    end
    if @type == 'exam'
      @item = Exam.find(id)
    end
    if @type == 'article'
      @item = Article.find(id)
    end

    @item.mark_as_done
  end

  def reveal
    id = params[:id]
    @type = params[:type]
    if @type == 'event'
      @item = Event.find(id)
    end
    if @type == 'task'
      @item = Task.find(id)
    end
    if @type == 'exam'
      @item = Exam.find(id)
    end
    if @type == 'article'
      @item = Article.find(id)
    end

    @item.mark_as_undone
  end

end