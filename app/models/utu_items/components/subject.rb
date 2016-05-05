class Subject < ActiveRecord::Base
  has_many :lessons
  has_many :exams
  has_many :tasks

  has_many :planned_raking_lists

  has_many :additional_infos

  validates_presence_of :name
  
  def get_exam_before_days
    exam = Exam.for_groups(User.current.sgroups).where("subject_id = ?", self).where("date <= ?", Date.today).order(date: :desc).first
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
  
  def get_exam_after_days
    exam = Exam.for_groups(User.current.sgroups).where("subject_id = ?", self).where("date > ?", Date.today).order(date: :asc).first
    if(!exam)
      return "zatím nikdy"
    end
    number_of_days = exam.date.mjd - Date.today.mjd
    
    if(number_of_days < 0)
      return "zatím nikdy"
    end
    if(number_of_days == 0)
      return "dnes"
    end
    if(number_of_days == 1)
      return "zítra"
    end
    if(number_of_days > 1 && number_of_days < 5)
      return "za #{number_of_days} dny"
    end
    if(number_of_days > 4)
      return "za #{number_of_days} dní"
    end
  end

  def get_total_exams
    number_of_exams = Exam.for_groups(User.current.sgroups).where("date <= ?", Date.today).where("subject_id = ?", self).count
    if(number_of_exams == 0)
      return "žádný test"
    end
    if(number_of_exams == 1)
      return "1 test"
    end
    if(number_of_exams > 1 && number_of_exams < 5)
      return "#{number_of_exams} testy"
    end
    if(number_of_exams > 4)
      return "#{number_of_exams} testů"
    end
  end

  def get_total_tasks
    number_of_tasks = Task.for_groups(User.current.sgroups).where("date <= ?", Date.today).where("subject_id = ?", self).count
    if(number_of_tasks == 0)
      return "žádný úkol"
    end
    if(number_of_tasks == 1)
      return "1 úkol"
    end
    if(number_of_tasks > 1 && number_of_tasks < 5)
      return "#{number_of_tasks} úkoly"
    end
    if(number_of_tasks > 4)
      return "#{number_of_tasks} úkolů"
    end
  end
    
  def get_average_time_between_exams
    previous = nil
    dates = []
    Exam.where(subject: self).pluck(:date).each do |date|
      if(previous != nil)
        dates << ((date - previous).to_i)
      end
      previous = date
    end
    if(dates.count == 0)
      return "žádné testy nenalezeny"
    end
    average_days = dates.inject(:+).to_i / dates.length
    if(average_days == 0)
      return "méně než jeden den"
    end
    if(average_days == 1)
      return "1 den"
    end
    if(average_days > 1 && average_days < 5)
      return "#{average_days} dny"
    end
    if(average_days > 4)
      return "#{average_days} dní"
    end
    return average_days
  end
  
  def get_next_expected_exam
    previous = nil
    dates = []
    Exam.where(subject: self).pluck(:date).each do |date|
      if(previous != nil)
        dates << ((date - previous).to_i)
      end
      previous = date
    end
    if(dates.count == 0)
      return "žádné testy nenalezeny"
    end
    average_days = dates.inject(:+).to_i / dates.length
    next_exam = Exam.last.date + average_days.days
    
    number_of_days = next_exam.mjd - Date.today.mjd
    
    if(number_of_days < -1)
      return "před #{number_of_days} dny"
    end
    if(number_of_days == -1)
      return "včera"
    end
    if(number_of_days == 0)
      return "dnes"
    end
    if(number_of_days == 1)
      return "zítra"
    end
    if(number_of_days > 1 && number_of_days < 5)
      return "za #{number_of_days} dny"
    end
    if(number_of_days > 4)
      return "za #{number_of_days} dní"
    end
  end
end
