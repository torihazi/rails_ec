# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy

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
end
