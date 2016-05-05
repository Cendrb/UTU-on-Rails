class DetailsAccess < ActiveRecord::Base
  belongs_to :user
  
  scope :in_time_from_now, lambda { |time| where("created_at >= :time AND created_at <= :time_now", { time: Time.now - time, time_now: Time.now }) }
  
  def self.log_new(current_user, ip, user_agent)
    last_visits = DetailsAccess.where("created_at >= :time AND created_at <= :time_now", {time: Time.now - 30.minutes, time_now: Time.now}).where("ip_address = :ip", {ip: ip})

    if (last_visits.count == 0)
      statisticsRecord = DetailsAccess.new()
      statisticsRecord.user = current_user
      statisticsRecord.ip_address = ip
      statisticsRecord.user_agent = user_agent
      statisticsRecord.save!
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
