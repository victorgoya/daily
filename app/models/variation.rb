class Variation < ApplicationRecord
  belongs_to :user, touch: true

  validates :value, presence: true
  validates :label, presence: true

  scope :from_today, -> { where("(variations.created_at + (variations.spread - 1) * interval '1 day' > ? OR variations.recurring = ?) AND variations.base = ?", Time.zone.now.beginning_of_day, true, false) }
  scope :from_this_month, -> { where("variations.created_at > ? OR variations.recurring = ?", Time.zone.now.beginning_of_month, true) }

  def daily_value
    if self.recurring?
      value / Time.zone.now.end_of_month.day
    else
      value.to_f / spread
    end
  end

  def monthly_value
    value
  end

  def monthly_value_up_to_date(day)
    current_spread = day - created_at.day
    if current_spread > spread
      0
    else
      daily_value * current_spread
    end
  end
end
