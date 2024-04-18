# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :basic_auth, only: %i[index show]
  before_action :set_promotion_code, only: %i[create]
  layout 'layouts/admins', only: %i[index show]

  def create
    @order = Order.new(order_params)
    @order.promotion_code_id = @promotion_code.id if session[:promotion_code]

    ApplicationRecord.transaction do
      @order.save!
      @cart.cart_products.each do |product|
        create_order_detail(@order, product)
      end
      @total_price = @order.total_price
      mail_to_customer
      reset_session
      @cart.destroy!
      flash[:success] = 'お買い上げありがとうございます'
      redirect_to root_path
    end
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = '購入に失敗しました'
    render 'carts/index', status: :unprocessable_entity
  end

  def index
    @orders = Order.preload(:order_details).page(params[:page])
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total_price = @order.total_price
  end

  private

  def order_params
    params.require(:order).permit(
      :first_name,
      :last_name,
      :user_name,
      :email,
      :address_line1,
      :address_line2,
      :cardholder_name,
      :card_number,
      :expiration_date,
      :security_code
    )
  end

  def create_order_detail(order, item)
    OrderDetail.create!(
      order_id: order.id,
      product_name: item.product.name,
      product_price: item.product.price,
      quantity: item.quantity
    )
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def mail_to_customer
    OrderDetailMailer.with(
      email: @order.email,
      order_details: @order.order_details,
      order: @order,
      total_price: @order.total_price
    ).checkout_mail.deliver_now
  end
end
