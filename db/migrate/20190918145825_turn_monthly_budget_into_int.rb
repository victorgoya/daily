class TurnMonthlyBudgetIntoInt < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :monthly_budget, :integer
  end
end
