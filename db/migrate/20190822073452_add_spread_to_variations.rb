class AddSpreadToVariations < ActiveRecord::Migration[5.2]
  def change
    add_column :variations, :spread, :integer, default: 1, null: false
  end
end
