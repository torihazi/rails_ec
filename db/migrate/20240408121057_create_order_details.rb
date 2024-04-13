# frozen_string_literal: true

class CreateOrderDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :order_details do |t|
      t.references :order, foreign_key: true
      t.string :product_name, null: false
      t.integer :product_price, null: false
      t.integer :quantity, null: false
      t.timestamps
    end
  end
end
