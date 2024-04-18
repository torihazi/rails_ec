# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_promotion_code
  def index
    @order = Order.new
    @cart_products = @cart.cart_products.preload(:product)
    @total_price = 0
    @cart_products.each do |item|
      @total_price += item.quantity * item.product.price
    end
    @total_price -= @promotion_code.discount if session[:promotion_code]
  end
end
