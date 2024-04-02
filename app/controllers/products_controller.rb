# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.eager_load(image_attachment: :blob).order(id: :asc).page(params[:page])
  end

  def show
    @product = Product.eager_load(image_attachment: :blob).find(params[:id])
    @related_products = Product.eager_load(image_attachment: :blob).order(created_at: :desc).limit(6)
  end
end
