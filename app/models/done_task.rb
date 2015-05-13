class DoneTask < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  
  def self.is_done_for?(user, item)
    return !DoneTask.where("user = :user AND task = :item", { user: user, item: item }).first.nil?
  end
end
