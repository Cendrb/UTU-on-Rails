xml.instruct!
xml.utu do
  xml.timetables do
    @data[:timetables].each do |timetable|
      xml.timetable(name: timetable.name, sgroup_ids: timetable.sgroups.pluck(:id)) do
        timetable.school_days.next_two_weeks_days.each do |day|
          xml.day(date: day.date) do
            day.lessons.each do |lesson|
              xml.lesson(room: lesson.room, not_normal: lesson.not_normal, not_normal_comment: lesson.not_normal_comment, subject_id: lesson.subject_id, teacher_id: lesson.teacher_id)
            end
          end
        end
      end
    end
  end
end