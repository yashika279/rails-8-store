class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products,
           through: :cart_items

  def total_amount
    cart_items.includes(:product).sum do |item|
      item.product.discounted_price * item.quantity
    end
  end
end
