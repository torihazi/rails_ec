# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [450, 300]
  end
  validates :name, presence: true, length: { maximum: 20 }
  validates :description, presence: true, length: { maximum: 255 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 1 }
  validates :image, attached: true,
                    content_type: { in: ['image/jpeg', 'image/png'], message: '拡張子は jpgもしくはpng形式です' },
                    size: { less_than: 5.megabytes, message: '容量上限は5MBです' }
end
