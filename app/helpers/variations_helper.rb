module VariationsHelper
  def current_monthly_budget
    @current_monthly_budget ||= @current_user.monthly_budget - @variations.map(&:monthly_value).sum
  end

  def current_daily_budget
    current_daily_budget ||= @current_user.daily_budget - @variations.map(&:daily_value).sum
  end

  def format_value(value)
    money = Money.new(value * 100, @current_user.currency)
    money.format(format: money.currency.to_s === "EUR" ? "%n %u" : "%u%n")
  end

  def saved_this_month
    return @saved_this_month if @saved_this_month

    remaining_monthly_budget = @current_user.monthly_budget - @current_user.variations.from_this_month.where(recurring: true).map(&:monthly_value).sum
    cumulated_daily_budget = remaining_monthly_budget / Time.now.end_of_month.day * (Time.now.day - 1)
    cumulated_daily_spendings = @current_user.variations.from_this_month.where(recurring: false).where("variations.created_at < ?", Time.now.beginning_of_day).map(&:daily_value).sum

    @saved_this_month ||= cumulated_daily_budget - cumulated_daily_spendings
  end
end
