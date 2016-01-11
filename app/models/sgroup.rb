class Sgroup < ActiveRecord::Base
  belongs_to :group_category
  has_many :group_belongings
  has_many :class_members, through: :group_belongings

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
      if(group == Sgroup.find_or_create_by("první skupina"))
        return 1
      end
      if(group == Sgroup.find_or_create_by("druhá skupina"))
        return 2
      end
    else
      return 0
    end
  end
end
