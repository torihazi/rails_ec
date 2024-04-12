class OrderDetailMailer < ApplicationMailer
  def checkout_mail
    email = params[:email]
    @order_details = params[:order_details]
    mail(to: email, subject: "Finish Checkout")
  end
end
