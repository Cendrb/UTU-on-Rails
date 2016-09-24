class ClassMember < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :sclass_id
  belongs_to :sclass
  has_one :user

  has_one :baka_account

  has_many :planned_raking_entries

  has_many :group_belongings, dependent: :destroy
  has_many :sgroups, through: :group_belongings

  has_many :seminar_belongings, dependent: :destroy
  has_many :seminars, through: :seminar_belongings

  def full_name
    return first_name + ' ' + last_name
  end

  def of_name
    return last_name + ' ' + first_name
  end
end
