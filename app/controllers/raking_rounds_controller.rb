class RakingRoundsController < ApplicationController
  def for_planned_raking_list
    @data = {}
    @data[:raking_rounds] = PlannedRakingList.find(params[:planned_raking_list_id]).raking_rounds
    puts @data[:raking_rounds]
    render 'raking_rounds/select_for_planned_raking_list'
  end
end