class Article < ActiveRecord::Base
  include GenericUtuItem
  include Hideable

  before_save do
    if self.published
      if self.published_on == nil
        self.published_on = Time.now
      end
    else
      if self.published_on != nil
        self.published_on = nil
      end
    end

    if self.show_in_details
      if self.show_in_details_until == nil
        self.show_in_details_until = Time.now + 7.day
      end
    else
      if self.show_in_details_until != nil
        self.show_in_details_until = nil
      end
    end
  end

  validates_presence_of :title, :text
end
