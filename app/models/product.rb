class Product < ApplicationRecord
  has_rich_text :description
  validates :name, presence: true

  has_one_attached :featured_image
end
