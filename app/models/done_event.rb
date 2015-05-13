class DoneEvent < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  def self.is_done_for?(user, item)
    return !DoneEvent.where("user = :user AND event = :item", { user: user, item: item }).first.nil?
  end
end
