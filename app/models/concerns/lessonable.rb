module Lessonable
  extend ActiveSupport::Concern

  included do
    before_create :init

    has_many :lesson_item_bindings, :as => :item, dependent: :destroy
    has_many :lessons, through: :lesson_item_bindings
  end

  def init
    self.passed = false
    true
  end

  def get_lesson_date
    if self.lessons.count > 0
      return self.lessons.first.school_day.date
    else
      return date
    end
  end

  def find_and_set_lesson
    # longest query
    # select first lesson from each timetable for sgroup, sclass and subject
    if !passed
      self.lessons = Lesson.select("DISTINCT ON (timetables.id) lessons.*").joins(school_day: :timetable).joins("LEFT JOIN group_timetable_bindings ON timetables.id = group_timetable_bindings.timetable_id").joins("LEFT JOIN sgroups ON sgroups.id = group_timetable_bindings.sgroup_id").where(":sclass = -1 OR timetables.sclass_id = :sclass", {sclass: self.sclass_id}).where(":sgroup = -1 OR sgroups.id = :sgroup", {sgroup: self.sgroup_id}).where("lessons.subject_id = ?", self.subject_id).where("school_days.date >= ?", self.date)
    end
  end
end