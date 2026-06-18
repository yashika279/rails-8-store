class CartItemsController < ApplicationController
  before_action :require_authentication

  def create
    cart = Current.user.cart
    product = Product.find(params[:product_id])

    cart_item = cart.cart_items.find_or_initialize_by(
      product: product
    )

    cart_item.quantity ||= 0
    cart_item.quantity += 1

    if cart_item.save
      redirect_to cart_path,
                  notice: "Product added to cart"
    else
      redirect_back fallback_location: products_path,
                    alert: "Unable to add product"
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to cart_path}
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update!(quantity: params[:cart_item][:quantity])

    @cart = @cart_item.cart

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to cart_path }
    end
  end
end