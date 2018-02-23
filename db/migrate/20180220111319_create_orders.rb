class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :ad, index: true, foreign_key: true
      t.integer :status, default: 0
      t.integer :buyer_id
      t.timestamps null: false
    end
  end
end
