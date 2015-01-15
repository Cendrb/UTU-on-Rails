class ChartsController < ApplicationController
  def accesses_per_hour_of_day
    render json: DetailsAccess.group_by_hour_of_day(:created_at).count
  end
  
  def accesses_per_day_of_week
    render json: DetailsAccess.group_by_day(:created_at, format: '%A').count
  end
end
