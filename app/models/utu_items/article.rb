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
  end

  validates_presence_of :text
end
