class AbsoluteTime

  attr_reader :hours, :minutes, :seconds

  @hours = 0
  @minutes = 0
  @seconds = 0

  def initialize(seconds)
    if !seconds.nil?
      @hours = seconds / 3600
      @minutes = (seconds % 3600) / 60
      @seconds = (seconds % 3600) % 60
    end
  end

  def to_hours_minutes_s
    return @hours.to_s.rjust(2, '0') + ':' + @minutes.to_s.rjust(2, '0')
  end

  def to_s
    return @hours.to_s.rjust(2, '0') + ':' + @minutes.to_s.rjust(2, '0') + ':' + @seconds.to_s.rjust(2, '0')
  end
end