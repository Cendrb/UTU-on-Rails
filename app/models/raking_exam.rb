class RakingExam < Exam
  def get_next_raking_date
    if(self.group == 0)
      # not group dependent
      if(self.subject.name == "HuO")
        # use HuO group (first)
        lesson_var = Lesson.joins(:school_day => :timetable).where("school_days.date >= ?", self.date).where(subject: self.subject).where("timetables.group = 1").order("school_days.date ASC").first
      else
        # use VýO group (second)
        lesson_var = Lesson.joins(:school_day => :timetable).where("school_days.date >= ?", self.date).where(subject: self.subject).where("timetables.group = 2").order("school_days.date ASC").first
      end
    else
      # group dependent
      lesson_var = Lesson.joins(:school_day => :timetable).where("school_days.date >= ?", self.date).where(subject: self.subject).where("timetables.group = ?", self.group).order("school_days.date ASC").first
    end
    return lesson_var.school_day.date
  end
end
