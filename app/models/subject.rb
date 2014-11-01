class Subject < ActiveRecord::Base
  has_many :lessons
  has_many :exams
  has_many :tasks
  
  def get_exam_before_days
    exam = Exam.where("subject_id = ?", self).order(date: :desc).first
    if(!exam)
      return "nikdy"
    end
    number_of_days = Date.today.mjd - exam.date.mjd
    
    if(number_of_days < 0)
      return "nikdy"
    end
    if(number_of_days == 0)
      return "dnes"
    end
    if(number_of_days == 1)
      return "včera"
    end
    if(number_of_days > 1)
      return "před #{number_of_days} dny"
    end
  end

  def get_total_exams
    return Exam.where("subject_id = ?", self).count
  end

  def get_total_tasks
    return Task.where("subject_id = ?", self).count
  end
end
