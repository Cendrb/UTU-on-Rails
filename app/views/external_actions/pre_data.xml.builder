xml.instruct!
xml.utu do
  xml.sclasses do
    @data[:sclasses].each do |sclass|
      xml.sclass(id: sclass.id, name: sclass.name) do
        xml.class_members do
          sclass.class_members.each do |member|
            xml.class_member(id: member.id, full_name: member.full_name)
          end
        end
      end
    end
  end
  xml.group_categories do
    @data[:group_categories].each do |group_category|
      xml.group_category(id: group_category.id, name: group_category.name) do
        xml.sgroups do
          group_category.sgroups.each do |sgroup|
            xml.sgroup(id: sgroup.id, name: sgroup.name)
          end
        end
      end
    end
  end
end