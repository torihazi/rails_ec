# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
    @related_products = Product.order(created_at: :desc).limit(6)
  end
end
