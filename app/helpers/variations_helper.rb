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

  def format_budget_value(value)
    if value < 0
      format_value(value.abs) + " overspent"
    else
      format_value(value) + " remaining"
    end
  end

  def saved_this_month
    return @saved_this_month if @saved_this_month

    remaining_monthly_budget = (@current_user.monthly_budget || 0) - @current_user.variations.from_this_month.where(recurring: true).map(&:monthly_value).sum
    cumulated_daily_budget = remaining_monthly_budget / Time.zone.now.end_of_month.day * (Time.zone.now.day - 1)
    cumulated_daily_spendings = @current_user.variations.from_this_month
      .where(recurring: false)
      .where("variations.created_at < ?", Time.zone.now.beginning_of_day)
      .map { |v| v.monthly_value_up_to_date(Time.zone.now.day) }.sum

    @saved_this_month ||= cumulated_daily_budget - cumulated_daily_spendings
  end

  def variations_for(recurring, range)
    if !recurring && range == 'this-month'
       @variations.where(recurring: false, base: true) + @variations.where(recurring: false, base: false).group_by(&:label).map do |label, variations|
        Variation.new(label: label, value: variations.map(&:value).sum)
      end
    else
      @variations.where(recurring: recurring)
    end
  end

  def spread_options_for(variation)
    options = { 1 => "No, only today" }

    date = (variation.created_at || DateTime.now).to_datetime
    days_before_end_of_the_month = (date.end_of_month - date).to_i

    if days_before_end_of_the_month > 7 # enough room for a week
      options[7] = "For 7 days"
    end

    options[days_before_end_of_the_month] = "Until the end of the month"

    options
  end
end
