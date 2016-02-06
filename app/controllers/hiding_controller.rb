class HidingController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate

  def hide
    id = params[:id]
    @type = params[:type]
    @item = GenericUtuItem.find_instance(id, @type)

    respond_to do |format|
      if @item.mark_as_done
        format.js
        format.whoa { return GenericUtuItem.success_string }
      else
        format.js
        format.whoa { return GenericUtuItem.failure_string }
      end
    end
  end

  def reveal
    id = params[:id]
    @type = params[:type]
    @item = GenericUtuItem.find_instance(id, @type)

    @item.mark_as_undone

    respond_to do |format|
      format.js
      format.whoa { return GenericUtuItem.success_string }
    end
  end

end