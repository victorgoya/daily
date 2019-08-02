class CreateVariations < ActiveRecord::Migration[5.2]
  def change
    create_table :variations do |t|
    	t.float :value
    	t.boolean :recurring
    	t.belongs_to :user
    	t.string :label
      t.timestamps
    end
  end
end
