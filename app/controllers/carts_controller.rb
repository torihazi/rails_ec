# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_cart, only: %i[index]

  def index
    @cart_products = @cart.cart_products.preload(:product)
    @total_price = 0
    @cart_products.each do |item|
      @total_price += item.quantity * item.product.price
    end
  end
end
