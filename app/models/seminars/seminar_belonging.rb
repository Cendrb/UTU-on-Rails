class SeminarBelonging < ActiveRecord::Base
  belongs_to :seminar
  belongs_to :class_member
end
