class LessonItemBinding < ActiveRecord::Base
  belongs_to :utu_item, polymorphic: true
  belongs_to :lesson
end
