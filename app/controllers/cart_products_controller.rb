# frozen_string_literal: true

class CartProductsController < ApplicationController
  before_action :create_cart
  before_action :set_cart

  def create
    cart_product = @cart.cart_products.find_by(product_id: params[:product_id])

    if cart_product.present?
      cart_product.quantity += params[:quantity].to_i
    else
      cart_product = @cart.cart_products.build(product_id: params[:product_id],
                                              quantity: params[:quantity]
                                              )
    end

    flash[:danger] = '商品が登録できませんでした' unless cart_product.save
    redirect_to request.referer
  end

  def destroy
    cart_product = @cart.cart_products.find(params[:id])
    cart_product.destroy
    flash[:success] = '商品を削除しました'
    redirect_to request.referer
  end
end
