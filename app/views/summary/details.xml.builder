xml.instruct!
xml.utu do
	xml.events do
		@events.each do |event|
			xml.event('id' => event.id, 'title' => event.title, 'description' => event.description, 'location' => event.location, 'eventStart' => event.event_start, 'eventEnd' => event.event_end, 'price' => event.price, 'payDate' => event.pay_date, 'additionalInfoUrl' => event.additional_info_url)
		end
	end
	xml.tasks do
		@tasks.each do |task|
			xml.task('id' => task.id, 'title' => task.title, 'description' => task.description, 'subject' => task.subject.id, 'date' => task.date, 'group' => task.group)
		end
	end
	xml.exams do
		@exams.each do |exam|
			xml.exam('id' => exam.id, 'title' => exam.title, 'description' => exam.description, 'subject' => exam.subject.id, 'date' => exam.date, 'group' => exam.group)
		end
	end
end