class User < ApplicationRecord
  has_many :variations, dependent: :destroy

  has_one :base_variation, -> (user) { user.variations.where(base: true) }, class_name: "Variation"

  def daily_budget(date)
    (monthly_budget.to_i - variations.from_this_month(date).find_by(base: true)&.value.to_i).to_i / date.end_of_month.day
  end
end
