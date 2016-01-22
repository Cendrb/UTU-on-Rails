class Sgroup < ActiveRecord::Base
  validates_presence_of :group_category, :name

  belongs_to :group_category

  has_many :group_belongings, dependent: :destroy
  has_many :class_members, through: :group_belongings

  has_many :group_timetable_bindings, dependent: :destroy
  has_many :timetables, through: :group_timetable_bindings

  has_many :articles


  def self.parse_deprecated(deprecated_group)
    if(deprecated_group == 0)
      return -1
    end
    if(deprecated_group == 1)
      return Sgroup.find_or_create_by("první skupina")
    end
    if(deprecated_group == 2)
      return Sgroup.find_or_create_by("druhá skupina")
    end
  end

  def self.get_deprecated(group)
    if(group)
      if(group == Sgroup.find_by_name("první skupina"))
        return 1
      end
      if(group == Sgroup.find_by_name("druhá skupina"))
        return 2
      end
      return 0
    else
      return 0
    end
  end
end
