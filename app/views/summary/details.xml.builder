xml.instruct!
xml.utu do
	xml.events do
		@events.each do |event|
			xml.event('id' => event.id, 'title' => event.title, 'description' => event.description, 'location' => event.location, 'eventStart' => event.event_start, 'eventEnd' => event.event_end, 'price' => event.price, 'payDate' => event.pay_date, 'additional_info_url' => event.additional_info_url)
		end
	end
	xml.tasks do
		@tasks.each do |task|
			if task.lessons.first.nil?
			  # use "hardcoded" date
				xml.task('id' => task.id, 'title' => task.title, 'description' => task.description, 'subject' => task.subject.name, 'date' => task.date, 'group' => Sgroup.get_deprecated(task.sgroup).to_s, 'additional_info_url' => task.additional_info_url)
			else
			  # use date based on timetable
				xml.task('id' => task.id, 'title' => task.title, 'description' => task.description, 'subject' => task.subject.name, 'date' => task.lessons.first.school_day.date, 'group' => Sgroup.get_deprecated(task.sgroup).to_s, 'additional_info_url' => task.additional_info_url)
			end
		end
	end
	xml.exams do
		@exams.each do |exam|
		  if exam.lessons.first.nil?
		    # use "hardcoded" date
		    xml.exam('id' => exam.id, 'title' => exam.title, 'description' => exam.description, 'subject' => exam.subject.name, 'date' => exam.date, 'group' => Sgroup.get_deprecated(exam.sgroup).to_s, 'additional_info_url' => exam.additional_info_url)
		  else
		    # use date based on timetable
		    xml.exam('id' => exam.id, 'title' => exam.title, 'description' => exam.description, 'subject' => exam.subject.name, 'date' => exam.lessons.first.school_day.date, 'group' => Sgroup.get_deprecated(exam.sgroup).to_s, 'additional_info_url' => exam.additional_info_url)
		  end
		end
	end
end