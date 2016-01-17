class DateUtils
  def overlaps_without_endpoints?(range1, range2)
    return (range1.first - range2.end) * (range2.first - range1.end) > 0
  end
end