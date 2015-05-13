class DoneExam < ActiveRecord::Base
  belongs_to :user
  belongs_to :exam
  
  def self.is_done_for?(user, item)
    return !DoneExam.where("user = :user AND exam = :item", { user: user, item: item }).first.nil?
  end
end
