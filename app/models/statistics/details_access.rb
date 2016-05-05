class DetailsAccess < ActiveRecord::Base
  belongs_to :user
  
  scope :in_time_from_now, lambda { |time| where("created_at >= :time AND created_at <= :time_now", { time: Time.now - time, time_now: Time.now }) }

  def DetailsAccess.format_visited_page_string(raw)
    case raw
      when 'summary'
        return 'přehled'
      when 'planned_raking_lists'
        return 'zkoušení'
      when 'details'
        return 'podrobnosti'
      when 'timetable'
        return 'rozvrh'
    end
  end

  def DetailsAccess.log_new(current_user, ip, user_agent, visited_page)
    last_visits = DetailsAccess.where("created_at >= :time AND created_at <= :time_now", {time: Time.now - 30.minutes, time_now: Time.now}).where("ip_address = :ip", {ip: ip})

    if last_visits.count == 0
      statistics_record = DetailsAccess.new()
      statistics_record.user = current_user
      statistics_record.ip_address = ip
      statistics_record.user_agent = user_agent
      statistics_record.visited_pages << visited_page
      statistics_record.save!
    else
      statistics_record = last_visits.first
      if !statistics_record.visited_pages.include?(visited_page)
        statistics_record.visited_pages << visited_page
        statistics_record.save!
      end
    end
  end
  
  def get_user_agent_string
    if self.user_agent == "Apache-HttpClient/UNAVAILABLE (java 1.4)"
        result = "Android app"
      else
        if self.user_agent == "" || self.user_agent == nil
          result = "Windows app"
        else
          agent = UserAgent.parse(self.user_agent)
          result = "#{agent.platform} (#{agent.browser})"
        end
      end
      return result
  end
end
