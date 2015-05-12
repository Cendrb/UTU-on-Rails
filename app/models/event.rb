class EventDateValidator < ActiveModel::Validator
  def validate(record)
    if record.event_end < record.event_start
      record.errors.add(:event_end, 'musí být později než začátek akce')
    end
  end
end

class Event < ActiveRecord::Base
  scope :in_future, -> { where('event_end >= :today', { today: Date.today }) }
  scope :between_dates, lambda { |from, to| where("event_start >= :from AND event_end <= :to", { from: from, to: to } ) }
  scope :id_not_on_list, lambda { |list| where("NOT (ARRAY[id] <@ ARRAY[:ids])", { ids: list } ) }
  scope :id_on_list, lambda { |list| where("ARRAY[id] <@ ARRAY[:ids]", { ids: list } ) }
  
  validates :title, :event_start, :event_end, :location, presence: {presence: true, message: "nesmí být prázdný"}
  validates :price, numericality: true
  validates_with EventDateValidator
  
  def is_done?
    return DoneEvent.where("user_id = :user AND event_id = :item", { user: User.current, item: self }).count > 0
  end
  
  def mark_as_undone
    DoneEvent.where("user_id = :user AND event_id = :item", { user: User.current, item: self }).destroy_all
  end
  
  def mark_as_done
    if(!is_done?)
      DoneEvent.create(user: User.current, event: self)
    end
  end
  
  
  def is_snoozed?
    return !SnoozedEvent.find_by("user_id = :user AND event_id = :item AND snooze_date > :now", { user: User.current, item: self, now: Time.now }).nil?
  end
  
  def snooze(snooze_date)
    if(!is_snoozed?)
      SnoozedEvent.create(user: User.current, event: self, snooze_date: snooze_date)
    end
  end
  
  def unsnooze
    SnoozedEvent.where("user_id = :user AND event_id = :item", { user: User.current, item: self }).destroy_all
  end
end
