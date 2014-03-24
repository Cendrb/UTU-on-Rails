xml.instruct!
xml.utu do
	xml.events do
		@events.each do |event|
			xml.event('id' => event.id, 'title' => event.title, 'description' => event.description, 'location' => event.location, 'eventStart' => event.event_start, 'eventEnd' => event.event_end)
		end
	end
	xml.tasks do
		@tasks.each do |task|
			xml.task('id' => task.id, 'title' => task.title, 'description' => task.description, 'subject' => task.subject, 'date' => task.date, 'group' => task.group)
		end
	end
	xml.exams do
		@exams.each do |exam|
			xml.exam('id' => exam.id, 'title' => exam.title, 'description' => exam.description, 'subject' => exam.subject, 'date' => exam.date, 'group' => exam.group)
		end
	end
end