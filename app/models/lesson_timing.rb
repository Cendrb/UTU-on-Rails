class LessonTiming < ActiveRecord::Base
  def self.insert_regular_timings
    LessonTiming.create(serial_number: 1, start: 8.hours.ago, duration: 45.minutes.ago)
    LessonTiming.create(serial_number: 2, start: (8.hours + 55.minutes).ago, duration: 45.minutes.ago)
    LessonTiming.create(serial_number: 3, start: 10.hours.ago, duration: 45.minutes.ago)
    LessonTiming.create(serial_number: 4, start: (10.hours + 45.minutes).ago, duration: 45.minutes.ago)
    LessonTiming.create(serial_number: 5, start: (11.hours + 45.minutes).ago, duration: 45.minutes.ago)
    LessonTiming.create(serial_number: 6, start: (12.hours + 35.minutes).ago, duration: 45.minutes.ago)
    LessonTiming.create(serial_number: 7, start: 14.hours.ago, duration: 45.minutes.ago)
    LessonTiming.create(serial_number: 8, start: (14.hours + 45.minutes).ago, duration: 45.minutes.ago)
    LessonTiming.create(serial_number: 9, start: (15.hours + 40.minutes).ago, duration: 45.minutes.ago)
    LessonTiming.create(serial_number: 10, start: (16.hours + 25.minutes).ago, duration: 45.minutes.ago)
    LessonTiming.create(serial_number: 11, start: (17.hours + 15.minutes).ago, duration: 45.minutes.ago)
    LessonTiming.create(serial_number: 12, start: 18.hours.ago, duration: 45.minutes.ago)
  end
end
