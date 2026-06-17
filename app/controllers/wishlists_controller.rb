class WishlistsController < ApplicationController
  before_action :require_authentication

  def create
    cart_item = CartItem.find(params[:cart_item_id])

    current_user.wishlists.create!(
      product: cart_item.product,
      quantity: cart_item.quantity
    )
  
    cart_item.destroy

    redirect_to cart_path
  end

  def index
    @wishlists = current_user.wishlists
  end

  def destroy
    wishlist = Wishlist.find(params[:id])
    wishlist.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to wishlists_path}
    end
  end

  def move_to_cart
    wishlist = Wishlist.find(params[:id])
  
    ActiveRecord::Base.transaction do
      cart_item = Current.user.cart.cart_items.find_or_initialize_by(
        product: wishlist.product
      )
  
      cart_item.quantity ||= 0
      cart_item.quantity += wishlist.quantity || 1
      cart_item.save!
  
      wishlist.destroy!
    end
  
    redirect_to cart_path, notice: "Item moved to cart"
  end
end