xml.instruct!
xml.utu do
  xml.timetables do
    @data[:timetables].each do |timetable|
      xml.timetable do
        xml.id timetable.id
        xml.name timetable.name
        xml.sgroup_ids timetable.sgroups.pluck(:id)
        timetable.school_days.next_two_weeks_days.each do |day|
          xml.day do
            xml.id day.id
            xml.date day.date
            day.lessons.each do |lesson|
              xml.lesson do
                xml.id lesson.id
                xml.serial_number lesson.serial_number
                xml.room lesson.room
                xml.not_normal lesson.not_normal
                xml.not_normal_comment lesson.not_normal_comment
                xml.event_name lesson.event_name
                xml.subject_id lesson.subject_id
                xml.teacher_id lesson.teacher_id
              end
            end
          end
        end
      end
    end
  end
end