class CreateLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items do |t|
      t.integer :order_id, null: false
      t.integer :variant_id, null: false
      t.integer :quantity
      t.decimal :price
      t.string :state

      t.timestamps
    end
    add_index :line_items, [:order_id, :variant_id]
  end
end
