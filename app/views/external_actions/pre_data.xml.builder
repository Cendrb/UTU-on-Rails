xml.instruct!
xml.utu do
  xml.status do
    xml.code(0)
    xml.message('Predata fetch successful')
  end
  xml.sclasses do
    @data[:sclasses].each do |sclass|
      xml.sclass do
        xml.id(sclass.id)
        xml.name(sclass.name)
        xml.class_members do
          sclass.class_members.each do |member|
            xml.class_member do
              xml.id(member.id)
              xml.first_name(member.first_name)
              xml.last_name(member.last_name)
              xml.sgroup_ids(member.sgroups.pluck(:id))
            end
          end
        end
      end
    end
  end
  xml.group_categories do
    @data[:group_categories].each do |group_category|
      xml.group_category do
        xml.id(group_category.id)
        xml.name(group_category.name)
        xml.sgroups do
          group_category.sgroups.each do |sgroup|
            xml.sgroup do
              xml.id(sgroup.id)
              xml.name(sgroup.name)
            end
          end
        end
      end
    end
  end
  xml.subjects do
    @data[:subjects].each do |item|
      xml.subject do
        xml.id(item.id)
        xml.name(item.name)
      end
    end
  end
  xml.teachers do
    @data[:teachers].each do |item|
      xml.teacher do
        xml.id(item.id)
        xml.name(item.name)
        xml.abbr(item.abbr)
      end
    end
  end
  xml.lesson_timings do
    @data[:lesson_timings].each do |item|
      xml.lesson_timing do
        xml.id(item.id)
        xml.serial_number(item.serial_number)
        xml.start(item.start)
        xml.duration(item.duration)
      end
    end
  end
end