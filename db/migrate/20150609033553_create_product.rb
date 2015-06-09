class CreateProduct < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.decimal :price
      t.string :description
      t.integer :merchant_id
    end
  end
end
