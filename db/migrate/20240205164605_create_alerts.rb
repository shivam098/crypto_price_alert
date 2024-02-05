class CreateAlerts < ActiveRecord::Migration[7.1]
  def change
    create_table :alerts do |t|
      t.integer :user_id
      t.string :coin_name
      t.float :target_price
      t.string :status

      t.timestamps
    end
  end
end
