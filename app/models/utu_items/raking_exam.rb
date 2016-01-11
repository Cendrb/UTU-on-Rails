class RakingExam < Exam
  validates :end_date, presence: {presence: true, message: "nesmí být prázdný"}
  
  def find_and_set_lesson
    # puts "\n\nDILDO\n\n"
    if(self.group == 0)
      # not group dependent
      if(self.subject.name == "HuO")
        # use HuO group (first)
        self.lesson = Lesson.joins(:school_day => :timetable).where("school_days.date >= ? AND school_days.date <= ?", Date.today, self.end_date).where(subject: self.subject).where("timetables.group = 1").order("school_days.date ASC").first
      else
        # use VýO group (second)
        self.lesson = Lesson.joins(:school_day => :timetable).where("school_days.date >= ? AND school_days.date <= ?", Date.today, self.end_date).where(subject: self.subject).where("timetables.group = 2").order("school_days.date ASC").first
      end
    else
      # group dependent
      self.lesson = Lesson.joins(:school_day => :timetable).where("school_days.date >= ? AND school_days.date <= ?", Date.today, self.end_date).where(subject: self.subject).where("timetables.group = ?", self.group).order("school_days.date ASC").first
    end
    if(self.lesson)
      self.date = self.lesson.school_day.date
    end
    
    if(self.group == 0)
      # not group dependent
      if(self.subject.name == "HuO")
        # use HuO group (first)
        lesson_var = Lesson.joins(:school_day => :timetable).where("school_days.date >= ?", self.end_date).where(subject: self.subject).where("timetables.group = 1").order("school_days.date ASC").first
      else
        # use VýO group (second)
        lesson_var = Lesson.joins(:school_day => :timetable).where("school_days.date >= ?", self.end_date).where(subject: self.subject).where("timetables.group = 2").order("school_days.date ASC").first
      end
    else
      # group dependent
      lesson_var = Lesson.joins(:school_day => :timetable).where("school_days.date >= ?", self.end_date).where(subject: self.subject).where("timetables.group = ?", self.group).order("school_days.date ASC").first
    end
    if lesson_var
      self.end_date = lesson_var.school_day.date
    end
  end
end
