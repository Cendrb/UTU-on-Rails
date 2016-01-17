class GroupTimetableBinding < ActiveRecord::Base
  belongs_to :timetable
  belongs_to :sgroup
end
