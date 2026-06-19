class Order < ApplicationRecord
  belongs_to :user

  has_many :order_items, dependent: :destroy

  enum :status,
  {
    pending: "pending",
    confirmed: "confirmed",
    shipped: "shipped",
    delivered: "delivered",
    cancelled: "cancelled"
  }
end
