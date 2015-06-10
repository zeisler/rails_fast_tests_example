class CreatePurchase < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :count
      t.integer :person_id
      t.integer :product_id
    end
  end
end
