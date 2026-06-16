class User < ApplicationRecord
  rolify
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_one :cart, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }


  after_commit :create_default_cart, on: :create

  private

  def create_default_cart
    create_cart
  end
end
