# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_cart, only: %i[index]

  def index
    @cart_items = @cart.cart_items
  end
end
