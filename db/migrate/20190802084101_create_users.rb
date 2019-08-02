class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
    	t.string :name
    	t.float :monthly_budget
    	t.float :savings, default: 0, null: false
      t.timestamps
    end
  end
end
