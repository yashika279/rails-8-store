class Product < ApplicationRecord
  has_rich_text :description

  belongs_to :category
  has_one :product_dimension, dependent: :destroy
  has_many :product_images, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_many :product_tags, dependent: :destroy
  has_many :tags, through: :product_tags
  has_many :cart_items, dependent: :destroy

  validates :inventory_count, numericality: { greater_than_or_equal_to: 0 }

  has_many :subscribers, dependent: :destroy

  after_update_commit :notify_subscribers, if: :back_in_stock?

  def back_in_stock?
    inventory_count_previously_was.zero? && inventory_count.positive?
  end

  def notify_subscribers
    subscribers.each do |subscriber|
      ProductMailer.with(product: self, subscriber: subscriber).in_stock.deliver_later
    end
  end

  searchkick

  def search_data
    {
      title: title,
      description: description,
      category: category,
      price: price
    }
  end

  def discounted_price
    price - (price * discount_percentage / 100.0)
  end
end
