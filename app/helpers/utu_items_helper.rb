module UtuItemsHelper
  def get_group_string(utu_item)
    if utu_item.sgroup
      return utu_item.sgroup.name
    else
      return 'všechny skupiny'
    end
  end

  def get_admin_links(utu_item)
    type = utu_item.get_utu_type

    show = (link_to mi.open_in_new, utu_item)
    destroy = (link_to mi.delete, utu_item, method: :delete, data: {confirm: "Doopravdy si přejete odstranit #{utu_item.title}?"})
    transform = (link_to mi.motorcycle, controller: "generic_actions", action: "transform_to_selection_dialog", item: utu_item, type: type, remote: true)

    if type == :task
      # task
      edit = (link_to mi.edit_mode, edit_task_path(utu_item))
    end
    if type == :event
      # event
      edit = (link_to mi.edit_mode, edit_event_path(utu_item))
      transform = ""
    end
    if type == :written_exam
      # written exam
      edit = (link_to mi.edit_mode, edit_written_exam_path(utu_item))
    end
    if type == :raking_exam
      # raking exam
      edit = (link_to mi.edit_mode, edit_raking_exam_path(utu_item))
    end

    return "#{show} #{edit} #{destroy} #{transform}".html_safe
  end
end