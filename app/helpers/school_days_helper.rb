module SchoolDaysHelper
  def get_weekday(i)
    case i
    when 0
      return "Po"
    when 1
      return "Út"
    when 2
      return "St"
    when 3
      return "Čt"
    when 4
      return "Pá"
    end
  end
end
