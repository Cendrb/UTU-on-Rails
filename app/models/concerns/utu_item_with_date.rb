module UtuItemWithDate
  extend ActiveSupport::Concern

  included do
    scope :in_future, lambda { where('date >= now()::date AND passed = false') }
    scope :filter_out_todays_after, lambda { |limiting_hour| where("CASE WHEN date_part('hour', now()) > :limiting_hour THEN date != now()::date ELSE true END", {limiting_hour: limiting_hour}) }
    scope :between_dates, lambda { |from, to| where("date >= :from AND date <= :to ", {from: from, to: to}) }

    validates :date, presence: {presence: true, message: "nesmí být prázdný"}
  end
end