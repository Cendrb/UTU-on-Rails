xml.instruct!
xml.utu do
  xml.current_user do |user|
    user.logged_in(logged_in?)
    user.admin_logged_in(admin_logged_in?)
    if current_user
      user.sclass_id(current_user.sclass.id)
    else
      user.sclass_id(-1)
    end
  end
  xml.current_service do
    if @data[:current_service]
      xml.id(@data[:current_service].id)
    end
  end
  xml.services do
    @data[:services].each do |service|
      xml.service do
        xml.id(service.id)
        xml.service_start(service.service_start)
        xml.service_end(service.service_end)
        xml.first_mate_id(service.first_mate_id)
        xml.second_mate_id(service.second_mate_id)
      end
    end
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
  xml.planned_raking_lists do
    @data[:planned_raking_lists].each do |list|
      xml.planned_raking_list do
        xml.id(list.id)
        xml.title(list.title)
        xml.subject_id(list.subject_id)
        xml.sgroup_id(list.sgroup_id)
        xml.rekt_per_round(list.rekt_per_hour)
        xml.additional_infos do
          list.additional_infos.each do |item|
            xml.additional_info do
              xml.id(item.id)
              xml.name(item.name)
              xml.url(item.url)
            end
          end
        end
        xml.planned_raking_rounds do
          list.raking_rounds.each do |round|
            xml.planned_raking_round do
              xml.id(round.id)
              xml.number(round.number)
              xml.planned_raking_entries do
                round.planned_raking_entries.order(:sorting_order).each do |entry|
                  xml.planned_raking_entry do
                    xml.id(entry.id)
                    xml.description(entry.description)
                    xml.finished(entry.finished)
                    xml.grade(entry.grade)
                    xml.sorting_order(entry.sorting_order)
                    xml.class_member_id(entry.class_member_id)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end