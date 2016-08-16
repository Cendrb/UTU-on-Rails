xml.instruct!
xml.utu do
  xml.current_user do |user|
    user.logged_in(logged_in?)
    user.admin_logged_in(admin_logged_in?)
    user.dick("penis")
  end
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
  xml.articles do
    @data[:articles].each do |item|
      render partial: '_generic_utu_partials/show.xml', locals: {item: item, builder: xml}
    end
  end
  if @data[:additional_infos] 
    xml.additional_infos_global do
      @data[:additional_infos].each do |item|
        xml.additional_info do
          xml.id(item.id)
          xml.name(item.name)
          xml.url(item.url)
          xml.subject do
            xml.id(item.subject_id)
            xml.name(item.subject.name)
          end
        end
      end
    end
  end
  xml.raking_lists do
    @data[:planned_raking_lists].each do |list|
      xml.raking_list do
        xml.id(list.id)
        xml.title(list.title)
        xml.subject_id(list.subject_id)
        xml.sgroup_id(list.sgroup_id)
        xml.raking_rounds do

        end
      end
    end
  end
end