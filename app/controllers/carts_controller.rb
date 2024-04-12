# frozen_string_literal: true

class CartsController < ApplicationController

  def index
    @cart_products = @cart.cart_products.preload(:product)
    @total_price = 0
    @cart_products.each do |item|
      @total_price += item.quantity * item.product.price
    end
    @order = Order.new
  end
end
