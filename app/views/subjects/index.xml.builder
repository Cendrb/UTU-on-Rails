xml.instruct!
@subjects.each do |subject|
  xml.subject('name' => subject.name)
end
