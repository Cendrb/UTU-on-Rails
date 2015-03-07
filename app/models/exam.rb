class Exam < ActiveRecord::Base
  belongs_to :subject
  belongs_to :lesson
  
  scope :in_future, -> { where('date >= :today', { today: Date.today }) }
  scope :for_group, lambda { |group| where("\"group\" = :group OR \"group\" = 0", { group: group }) }
  scope :between_dates, lambda { |from, to| where("date >= :from AND date <= :to", { from: from, to: to } ) }
  scope :id_not_on_list, lambda { |list| where("NOT (ARRAY[id] <@ ARRAY[:ids])", { ids: list } ) }
  scope :id_on_list, lambda { |list| where("ARRAY[id] <@ ARRAY[:ids]", { ids: list } ) }
  
  validates :title, :subject_id, :group, :date, presence: {presence: true, message: "nesmí být prázdný"}
  validates :group, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 2, only_integer: true, message: "neexistuje - zadejte 0 pro obě skupiny" }
  
  def get_task
    Task.new(title: title, description: description, subject: subject, group: group, date: date)
  end
  
  def is_done?
    return !DoneExam.find_by("user_id = :user AND exam_id = :item", { user: User.current, item: self }).nil?
  end
  
  def mark_as_undone
    DoneExam.where("user_id = :user AND exam_id = :item", { user: User.current, item: self }).destroy_all
  end
  
  def mark_as_done
    if(!is_done?)
      DoneExam.create(user: User.current, exam: self)
    end
  end
  
  def is_snoozed?
    return !SnoozedExam.find_by("user_id = :user AND exam_id = :item AND snooze_date > :now", { user: User.current, item: self, now: Time.now }).nil?
  end
  
  def snooze(snooze_date)
    if(!is_snoozed?)
      SnoozedExam.create(user: User.current, exam: self, snooze_date: snooze_date)
    end
  end
  
  def unsnooze
    SnoozedExam.where("user_id = :user AND exam_id = :item", { user: User.current, item: self }).destroy_all
  end
  
  def find_and_set_lesson
    # puts "\n\nDILDO\n\n"
    if(self.group == 0)
      # not group dependent
      if(self.subject.name == "HuO")
        # use HuO group (first)
        self.lesson = Lesson.joins(:school_day => :timetable).where("school_days.date >= ?", self.date).where(subject: self.subject).where("timetables.group = 1").first
      else
        # use VýO group (second)
        self.lesson = Lesson.joins(:school_day => :timetable).where("school_days.date >= ?", self.date).where(subject: self.subject).where("timetables.group = 2").first
      end
    else
      # group dependent
      self.lesson = Lesson.joins(:school_day => :timetable).where("school_days.date >= ?", self.date).where(subject: self.subject).where("timetables.group = ?", self.group).first
    end
  end
end
