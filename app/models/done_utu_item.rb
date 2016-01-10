class DoneUtuItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :utu_item, polymorphic: true
end
