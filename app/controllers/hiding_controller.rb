class HidingController < ApplicationController
  before_filter :authenticate

  def hide
    id = params[:id]
    @type = params[:type]
    @item = GenericUtuItem.find_instance(id, @type)

    @item.mark_as_done
  end

  def reveal
    id = params[:id]
    @type = params[:type]
    @item = GenericUtuItem.find_instance(id, @type)

    @item.mark_as_undone
  end

end