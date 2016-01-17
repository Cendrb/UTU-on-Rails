class LessonItemBinding < ActiveRecord::Base
  belongs_to :item, polymorphic: true
  belongs_to :lesson

  validates_presence_of :item_id, :item_type, :lesson
end
