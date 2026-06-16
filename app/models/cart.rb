class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  def total_amount
    cart_items.sum do |item|
      item.quantity * item.product.price
    end
  end
end
