class ChartsController < ApplicationController
  def accesses_per_hour_of_day
    render json: DetailsAccess.group_by_hour_of_day(:created_at).count
  end

  def accesses_per_day_of_week
    render json: DetailsAccess.group_by_day(:created_at, week_start: :mon, format: '%A').count
  end

  def accesses_per_device
    data = {}
    DetailsAccess.find_each do |access|
      agent = AgentOrange::UserAgent.new(access.user_agent)
      if !data[agent.device.platform.type]
        data[agent.device.platform.type] = 0
      end
        data[agent.device.platform.type] += 1

    end
    render json: data
  end
end
