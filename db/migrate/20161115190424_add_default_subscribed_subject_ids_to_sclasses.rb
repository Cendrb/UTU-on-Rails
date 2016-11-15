class AddDefaultSubscribedSubjectIdsToSclasses < ActiveRecord::Migration
  def change
    add_column :sclasses, :default_subscribed_subject_ids, :integer, array: true, default: []
  end
end
