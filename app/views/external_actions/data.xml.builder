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
  xml.additional_infos do
    @data[:additional_infos].each do |item|
      xml.additional_info do
        xml.id(item.id)
        xml.name(item.name)
        xml.url(item.url)
      end
    end
  end
end