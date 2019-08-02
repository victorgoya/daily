class AddCurrencyToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :currency, :string, default: "EUR"
  end
end
