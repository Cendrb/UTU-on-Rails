class SeminarLesson < ActiveRecord::Base
  belongs_to :seminar
  belongs_to :teacher
end
