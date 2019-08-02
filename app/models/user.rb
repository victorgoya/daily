class User < ApplicationRecord
  has_many :variations, dependent: :destroy

  has_one :base_variation, -> (user) { user.variations.where(base: true) }, class_name: "Variation"

  def daily_budget
    (monthly_budget || 0) / Time.now.end_of_month.day
  end
end
