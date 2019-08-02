class AddBaseToVariations < ActiveRecord::Migration[5.2]
  def change
    add_column :variations, :base, :boolean, default: false
  end
end
