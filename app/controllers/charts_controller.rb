class ChartsController < ApplicationController
  def accesses_per_hour_of_day
    render json: DetailsAccess.group_by_hour_of_day(:created_at).count
  end

  def accesses_per_day_of_week
    render json: DetailsAccess.group_by_day(:created_at, week_start: :mon, format: '%A').count
  end

  def accesses_per_device
    data = {}
    result = "penis"
    DetailsAccess.find_each do |access|
      if access.user_agent == "Apache-HttpClient/UNAVAILABLE (java 1.4)"
        result = "Android app"
      else
        if access.user_agent == ""
          result = "Windows app"
        else
          agent = AgentOrange::UserAgent.new(access.user_agent)
          result = agent.device.platform.type
        end
      end
      if !data[result]
        data[result] = 0
      end
        data[result] += 1
    end
    render json: data
  end
end
