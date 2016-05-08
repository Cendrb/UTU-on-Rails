class ChartsController < ApplicationController

  def accesses_per_hour_of_day
    render json: DetailsAccess.group_by_hour_of_day(:created_at).count
  end

  def accesses_per_hour_of_last_day
    render json: DetailsAccess.group_by_hour_of_day(:created_at, range: 1.days.ago.midnight..Time.now).count
  end

  def accesses_per_day_of_week
    render json: DetailsAccess.group_by_day_of_week(:created_at, week_start: :mon, format: "%A").count
  end

  def accesses_per_device
    data = {}
    result = "this shouldn't happen"
    DetailsAccess.find_each do |access|
      if access.user_agent == "Apache-HttpClient/UNAVAILABLE (java 1.4)"
        result = "Android app"
      else
        if access.user_agent == "" || access.user_agent == nil
          result = "Windows app"
        else
          agent = UserAgent.parse(access.user_agent)
          result = "#{agent.platform} (#{agent.browser})"
        end
      end
      if !data[result]
        data[result] = 1
      end
      data[result] += 1
    end
    render json: data
  end

  def accesses_per_user
    users = DetailsAccess.group(:user).count
    without_login = users[nil]
    users[nil] = users.delete ""
    users["Bez přihlášení"] = without_login
    render json: users
  end

  def accesses_per_user_type
    types = {}
    DetailsAccess.find_each do |access|
      result = ""
      if access.user.nil?
        result = "Nepřihlášen"
      else
        result = "Přihlášen"
        if access.user_agent == "Apache-HttpClient/UNAVAILABLE (java 1.4)"
          result += " (z Android aplikace)"
        else
          if access.user_agent == "" || access.user_agent == nil
            result += " (z Windows aplikace)"
          else
            result += " (z prohlížeče)"
          end
        end
      end
      if !types[result]
        types[result] = 1
      end
      types[result] += 1
    end

    render json: types
  end

  def accesses_per_ip
    render json: DetailsAccess.group(:ip_address).count
  end
  
  def accesses_per_last_month_in_days
    render json: DetailsAccess.group_by_day(:created_at, format: '%e. %B', range: 1.month.ago..Time.now).count
  end

  def accesses_per_visited_page_type
    types = {}
    DetailsAccess.find_each do |access|
      access.visited_pages.each do |visited_page|
        visited_page = DetailsAccess.format_visited_page_string(visited_page)
        if types[visited_page]
          types[visited_page] += 1
        else
          types[visited_page] = 1
        end
      end
    end
    render json: types
  end
end
