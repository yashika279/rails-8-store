class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :product_id,
            uniqueness: { scope: :cart_id }

  validates :quantity,
            numericality: {
              greater_than: 0
            }

  def subtotal
    quantity * product.discounted_price
  end
end
