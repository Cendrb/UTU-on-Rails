module UtuItemsHelper
  def get_group_string(utu_item)
    if utu_item.sgroup
      return utu_item.sgroup.name
    else
      return 'všechny skupiny'
    end
  end
end