class CreateMerchant < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :address
      t.string :name
    end
  end
end
