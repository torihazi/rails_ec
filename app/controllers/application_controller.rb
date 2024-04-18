# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :create_cart
  before_action :set_cart
  before_action :set_cart_products

  private

  def create_cart
    return if session[:cart_id]

    cart = Cart.create
    session[:cart_id] = cart.id
  end

  def set_cart
    @cart = Cart.find(session[:cart_id])
  end

  def set_cart_products
    @cart_products = @cart.cart_products.preload(:product)
  end

  def set_promotion_code
    @promotion_code = if session[:promotion_code]
                        PromotionCode.find_by(code: session[:promotion_code])
                      else
                        PromotionCode.new
                      end
  end
end
