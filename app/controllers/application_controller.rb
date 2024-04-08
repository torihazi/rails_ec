# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :create_cart
  before_action :set_cart

  private

  def create_cart
    return if session[:cart_id]

    cart = Cart.create
    session[:cart_id] = cart.id
  end

  def set_cart
    @cart = Cart.find(session[:cart_id])
  end
end
