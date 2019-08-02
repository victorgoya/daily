class AddDefaultsToVariations < ActiveRecord::Migration[5.2]
  def change
    change_column :variations, :label, :string, null: false, index: true
    change_column :variations, :recurring, :boolean, null: false, default: false
    change_column :variations, :value, :float, null: false
  end
end
