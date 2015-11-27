class Exam < ActiveRecord::Base
  belongs_to :subject
  belongs_to :lesson
  
  self.inheritance_column = :type
  
  scope :rakings, -> { where(type: 'RakingExam') } 
  scope :written, -> { where(type: 'WrittenExam') } 
  
  scope :in_future, -> { where('date >= :today AND passed = false', { today: Date.today }) }
  scope :for_groups, lambda { |groups| where("sgroup_id IN (:groups)", { groups: groups.select(:id) }) }
  scope :between_dates, lambda { |from, to| where("date >= :from AND date <= :to", { from: from, to: to } ) }
  scope :id_not_on_list, lambda { |list| where("NOT (ARRAY[id] <@ ARRAY[:ids])", { ids: list } ) }
  scope :id_on_list, lambda { |list| where("ARRAY[id] <@ ARRAY[:ids]", { ids: list } ) }
  
  validates :title, :subject_id, :group, presence: {presence: true, message: "nesmí být prázdný"}
  validates :group, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 2, only_integer: true, message: "neexistuje - zadejte 0 pro obě skupiny" }

  belongs_to :sclass
  belongs_to :sgroup
  
  has_many :info_item_bindings
  has_many :done_exams
    
  before_create :init
  
  def self.types
    %(RakingExam WrittenExam)
  end
  
  def init
     self.passed = false
     true
  end
  
  def get_task
    Task.new(title: title, description: description, subject: subject, group: group, date: date)
  end
  
  def is_done?
    return DoneExam.where("user_id = :user AND exam_id = :item", { user: User.current, item: self }).count > 0
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
        self.lesson = Lesson.joins(:school_day => :timetable).where("school_days.date >= ?", self.date).where(subject: self.subject).where("timetables.group = 1").order("school_days.date ASC").first
      else
        # use VýO group (second)
        self.lesson = Lesson.joins(:school_day => :timetable).where("school_days.date >= ?", self.date).where(subject: self.subject).where("timetables.group = 2").order("school_days.date ASC").first
      end
    else
      # group dependent
      self.lesson = Lesson.joins(:school_day => :timetable).where("school_days.date >= ?", self.date).where(subject: self.subject).where("timetables.group = ?", self.group).order("school_days.date ASC").first
    end
    if(self.lesson)
      self.date = self.lesson.school_day.date
    end
  end
end
