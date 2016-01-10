class LessonItemBinding < ActiveRecord::Base
  belongs_to :item, polymorphic: true
  belongs_to :lesson
end
