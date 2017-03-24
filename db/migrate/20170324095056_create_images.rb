class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :asset
      t.integer :picturable_id
      t.string :picturable_type

      t.timestamps
    end
    add_index :images, [:picturable_id, :picturable_type]
  end
end
