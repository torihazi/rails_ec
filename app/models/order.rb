# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :promotion_code, optional: true

  validates :first_name, presence: true, length: { maximum: 10 }
  validates :last_name, presence: true, length: { maximum: 10 }
  validates :user_name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 254 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :address_line1, presence: true
  validates :address_line2, presence: true
  validates :cardholder_name, presence: true,
                              format: { with: /\A[A-Z]+ [A-Z]+\z/ }
  validates :card_number, presence: true,
                          format: { with: /\A\d{14,16}\z/ }
  validates :expiration_date, presence: true,
                              format: { with: %r{\A\d{2}/\d{2}\z} }
  validates :security_code, presence: true,
                            format: { with: /\A\d{3}\z/ }

  def total_price
    price = 0
    order_details.each do |i|
      price += i.quantity * i.product_price
    end
    price -= promotion_code.discount if promotion_code.present?
  end
end
