module VariationsHelper
  def current_monthly_budget
    @current_user.monthly_budget - @variations.map(&:monthly_value).sum
  end

  def current_daily_budget
    @current_user.daily_budget - @variations.map(&:daily_value).sum
  end
end
