# frozen_string_literal: true

class RemoveOrderidFromPromotionCode < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :promotion_codes, :orders
    remove_index :promotion_codes, :order_id
    remove_reference :promotion_codes, :order
  end
end
