module DateHelper
  def format_date(date)
    return "#{l date} (#{I18n.t(:"date.day_names")[date.wday]})"
  end

  def get_weekday(wday)
    return I18n.t(:"date.day_names")[wday]
  end
end
