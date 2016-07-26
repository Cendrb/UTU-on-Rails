type = item.get_utu_type

builder.item do
  builder.id(item.id)
  builder.type(type.to_s)
  builder.title(item.title)
  if type == :article
    builder.description(item.text)
  else
    builder.description(item.description)
  end
  if type == :event
    builder.location(item.location)
    builder.price(item.price)
    builder.start(item.event_start)
    builder.end(item.event_end)
    builder.pay_date(item.pay_date)
  else
    if type == :article
      builder.published_on(item.published_on)
    else
      builder.date(item.get_lesson_date)
      builder.subject do
        builder.id(item.subject_id)
        builder.name(item.subject.name)
      end
    end
  end
  if item.sgroup
    builder.sgroup do
      builder.id(item.sgroup_id)
      builder.name(item.sgroup.name)
    end
  else
    builder.sgroup do
      builder.id(item.sgroup_id)
    end
  end
  builder.additional_infos do
    item.info_item_bindings.each do |binding|
      builder.additional_info do
        builder.id(binding.additional_info.id)
        builder.name(binding.additional_info.name)
        builder.url(binding.additional_info.url)
      end
    end
  end
  builder.done(logged_in? && item.is_done?)
end