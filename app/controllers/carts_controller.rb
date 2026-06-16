class CartsController < ApplicationController
  def show
    @cart = Current.user.cart
  end
end
