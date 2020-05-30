class Variation < ApplicationRecord
  belongs_to :user, touch: true

  validates :value, presence: true
  validates :label, presence: true

  scope :from_today, -> (date) {
    where(%{
      (
        (? < variations.created_at + variations.spread * interval '1 day' AND ? > variations.created_at) OR
        (variations.recurring = ? AND ? < date_trunc('MONTH', variations.created_at)::DATE + variations.spread * interval '1 month')
      ) AND variations.base = ?
    }, date.end_of_day, date.end_of_day, true, date.beginning_of_month, false)
  }
  scope :from_this_month, -> (date) {
    where(%{
      variations.created_at > ? OR
      (variations.recurring = ? AND ? < date_trunc('MONTH', variations.created_at)::DATE + variations.spread * interval '1 month')
    }, date.beginning_of_month, true, date.beginning_of_month)
  }

  def daily_value(date)
    if self.recurring?
      value / date.end_of_month.day
    else
      value.to_f / spread
    end
  end

  def monthly_value
    value
  end

  def monthly_value_up_to_date(date)
    current_spread = date.day - created_at.day + 1
    if current_spread > spread
      value
    else
      daily_value(date) * current_spread
    end
  end
end
