# frozen_string_literal: true

module Admin
  class ProductsController < ApplicationController
    before_action :basic_auth
    before_action :set_product, only: %i[edit update destroy]
    skip_before_action :create_cart, :set_cart
    layout 'layouts/admins'

    def index
      @products = Product.eager_load(image_attachment: :blob).order(id: :asc).page(params[:page])
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)

      if @product.save
        flash[:success] = '商品を登録しました。'
        redirect_to admin_products_url
      else
        render 'new', status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @product.update(product_params)
        flash[:success] = '更新が完了しました'
        redirect_to admin_products_url
      else
        render 'edit', status: :unprocessable_entity
      end
    end

    def destroy
      @product.destroy
      flash[:success] = '削除が成功しました'
      redirect_to admin_products_url, status: :see_other
    end

    private

    def basic_auth
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
      end
    end

    def product_params
      params.require(:product).permit(:name, :price, :description, :image)
    end

    def set_product
      @product = Product.find(params[:id])
    end
  end
end
