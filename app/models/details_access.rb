class DetailsAccess < ActiveRecord::Base
  belongs_to :user
  
  scope :in_time_from_now, lambda { |time| where("created_at >= :time AND created_at <= :time_now", { time: Time.now - time, time_now: Time.now }) }
  
  def self.log_new(current_user, ip, user_agent)
    last_exams_in_3_minutes = DetailsAccess.where("created_at >= :time AND created_at <= :time_now", { time: Time.now - 3.minutes, time_now: Time.now }).where("ip_address = :ip", {ip: ip})
    
    if(last_exams_in_3_minutes.count == 0)
      statisticsRecord = DetailsAccess.new()
      statisticsRecord.user = current_user
      statisticsRecord.ip_address = ip
      statisticsRecord.user_agent = user_agent
      statisticsRecord.save!
    end
  end
end
