# frozen_string_literal: true

class RenameCartItemToCartProduct < ActiveRecord::Migration[7.0]
  def up
    rename_table :cart_Items, :cart_products
  end

  def down
    rename_table :cart_products, :cart_Items
  end
end
