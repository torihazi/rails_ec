# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def sum_price
    total_price = 0
    cart_items.each do |item|
      total_price += item.amount
    end
    total_price
  end

  def sum_quantity
    cart_items.sum(:quantity)
  end
end
