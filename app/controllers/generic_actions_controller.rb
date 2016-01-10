class GenericActionsController < ApplicationController
  def transform_to_selection_dialog
    id = params[:item].to_i
    if params[:type]
      if params[:type] == "task"
        @item = Task.find(id)
      else
        if params[:type] == "written_exam"
          @item = WrittenExam.find(id)
        else
          @item = RakingExam.find(id)
        end
      end
    end
    @type = params[:type]
    render "_generic_utu_partials/transform_to_selection_dialog/dialog_transform_to"
  end
end