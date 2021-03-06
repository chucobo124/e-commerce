class CreateVariants < ActiveRecord::Migration[5.0]
  def change
    create_table :variants do |t|
      t.string :name
      t.string :sku, null: false, :unique => true
      t.integer :count_on_hand, default: 0
      t.string :state
      t.boolean :visible, default: false
      t.boolean :is_default, default: false
      t.integer :product_id
      t.references :imageable, polymorphic: true, index: true
      t.timestamps
    end
    add_index(:variants, :product_id)
  end
end
