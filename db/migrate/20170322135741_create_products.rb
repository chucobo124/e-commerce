class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, null: false, default: ''
      t.string :description, null: false, default: ''
      t.decimal :price, null: false, default: 0
      t.decimal :discount_price

      t.timestamps
    end
  end
end
