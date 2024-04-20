# frozen_string_literal: true

class OrderDetailMailer < ApplicationMailer
  def checkout_mail
    email = params[:email]
    @order_details = params[:order_details]
    @order = params[:order]
    @total_price = params[:total_price]
    mail(to: email, subject: 'Finish Checkout')
  end
end
