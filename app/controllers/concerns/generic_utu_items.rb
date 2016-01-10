module GenericUtuItems
  extend ActiveSupport::Concern

  included do
    validates :title, :sgroup_id, :sclass_id, presence: {presence: true, message: "nesmí být prázdný"}
  end
end