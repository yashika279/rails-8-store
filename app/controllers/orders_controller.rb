class OrdersController < ApplicationController
  before_action :require_authentication

  def new
    @cart = Current.user.cart
    @addresses = Current.user.addresses
    @default_address = @addresses.find_by(default: true)
  end

  def create
    cart = Current.user.cart
    address = current_user.addresses.find(params[:address_id])
  
    order = current_user.orders.create!(
      total_amount: cart.total_amount,
      status: "pending",
    
      shipping_name: address.full_name,
      shipping_phone: address.phone,
      shipping_address_line_1: address.address_line_1,
      shipping_address_line_2: address.address_line_2,
      shipping_city: address.city,
      shipping_state: address.state,
      shipping_postal_code: address.postal_code
    )

    cart.cart_items.each do |cart_item|
      order.order_items.create!(
        product: cart_item.product,
        quantity: cart_item.quantity,
        price: cart_item.product.discounted_price
      )
    end

    cart.cart_items.destroy_all

    redirect_to order_path(order)
  end

  def show
    @order = Order.find(params[:id])
  end
end