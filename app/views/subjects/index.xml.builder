xml.instruct!
@subjects.each do |subject|
  xml.subject('id' => subject.id, 'name' => subject.name)
end
