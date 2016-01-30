xml.instruct!
xml.utu do
  xml.events do
    @data[:events].each do |item|
      render partial: '_generic_utu_partials/show.xml', locals: {item: item, builder: xml}
    end
  end
  xml.tasks do
    @data[:tasks].each do |item|
      render partial: '_generic_utu_partials/show.xml', locals: {item: item, builder: xml}
    end
  end
  xml.exams do
    @data[:exams].each do |item|
      render partial: '_generic_utu_partials/show.xml', locals: {item: item, builder: xml}
    end
  end
  xml.subjects do
    @data[:subjects].each do |item|
      xml.subject(id: item.id, name: item.name)
    end
  end
  xml.additional_infos do
    @data[:additional_infos].each do |item|
      xml.additional_info(id: item.id, name: item.name, url: item.url)
    end
  end
end