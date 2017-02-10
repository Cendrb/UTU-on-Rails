class LessonTiming < ActiveRecord::Base

  def start_time
    return AbsoluteTime.new(self[:start])
  end

  def duration_time
    return AbsoluteTime.new(self[:duration])
  end

  def self.insert_regular_timings
    LessonTiming.create(serial_number: 1, start: 8.hours.to_i, duration: 45.minutes.to_i)
    LessonTiming.create(serial_number: 2, start: (8.hours + 55.minutes).to_i, duration: 45.minutes.to_i)
    LessonTiming.create(serial_number: 3, start: 10.hours.to_i, duration: 45.minutes.to_i)
    LessonTiming.create(serial_number: 4, start: (10.hours + 45.minutes).to_i, duration: 45.minutes.to_i)
    LessonTiming.create(serial_number: 5, start: (11.hours + 45.minutes).to_i, duration: 45.minutes.to_i)
    LessonTiming.create(serial_number: 6, start: (12.hours + 35.minutes).to_i, duration: 45.minutes.to_i)
    LessonTiming.create(serial_number: 7, start: 14.hours.to_i, duration: 45.minutes.to_i)
    LessonTiming.create(serial_number: 8, start: (14.hours + 45.minutes).to_i, duration: 45.minutes.to_i)
    LessonTiming.create(serial_number: 9, start: (15.hours + 40.minutes).to_i, duration: 45.minutes.to_i)
    LessonTiming.create(serial_number: 10, start: (16.hours + 25.minutes).to_i, duration: 45.minutes.to_i)
    LessonTiming.create(serial_number: 11, start: (17.hours + 15.minutes).to_i, duration: 45.minutes.to_i)
    LessonTiming.create(serial_number: 12, start: 18.hours.to_i, duration: 45.minutes.to_i)
  end
end
