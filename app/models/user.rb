class User < ApplicationRecord
  has_many :variations, dependent: :destroy

  has_one :base_variation, -> (user) { user.variations.where(base: true) }, class_name: "Variation"

  def daily_budget
    (monthly_budget.to_i - variations.from_this_month.find_by(base: true)&.value.to_i).to_i / Time.zone.now.end_of_month.day
  end
end
