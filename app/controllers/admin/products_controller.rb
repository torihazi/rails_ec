# frozen_string_literal: true

module Admin
  class ProductsController < ApplicationController
    before_action :basic_auth
    layout 'layouts/admins'

    def index
      @products = Product.eager_load(image_attachment: :blob)
      @products = @products.order(id: :asc).page(params[:page])
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

    def edit
      @product = Product.find(params[:id])
    end

    def update
      @product = Product.find(params[:id])
      if @product.update(product_params)
        flash[:success] = '更新が完了しました'
        redirect_to admin_products_url
      else
        render 'edit', status: :unprocessable_entity
      end
    end

    def destroy
      Product.find(params[:id]).destroy
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
  end
end
