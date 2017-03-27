class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :user_id, null: false
      t.string :state
      t.datetime :completed_at

      t.timestamps
    end
    add_index :orders, :user_id
  end
end
