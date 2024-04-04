# frozen_string_literal: true

class CartItemsController < ApplicationController
  before_action :create_cart
  before_action :set_cart

  def create
    product = Product.find(params[:product_id])

    if @cart.products.include?(product)
      cart_item = @cart.cart_items.find_by(product_id: product.id)
      cart_item.quantity += params[:quantity].to_i
    else
      cart_item = CartItem.new(cart_id: @cart.id,
                               product_id: product.id,
                               quantity: params[:quantity])
    end

    flash[:danger] = '商品が登録できませんでした' unless cart_item.save
    redirect_to request.referer
  end

  def destroy
    cart_item = @cart.cart_items.find(params[:id])
    cart_item.destroy
    flash[:success] = '商品を削除しました'
    redirect_to request.referer
  end
end
