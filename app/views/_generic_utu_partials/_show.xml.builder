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
      builder.subject(id: item.subject_id, name: item.subject.name)
    end
  end
  if item.sgroup
    builder.sgroup(id: item.sgroup_id, name: item.sgroup.name)
  else
    builder.sgroup(id: item.sgroup_id)
  end
  builder.additional_infos do
    item.additional_infos.each do |info|
      builder.additional_info(id: info.id, name: info.name, url: info.url)
    end
  end
  builder.done(logged_in? && item.is_done?)
end