xml.instruct!
xml.subjects do
  @subjects.each do |subject|
    xml.subject('id' => subject.id, 'name' => subject.name)
  end
end
