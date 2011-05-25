class ApplicationController < ActionController::Base
  protect_from_forgery


  # -------- private methods -------- #
  private

  def current_cart
    Cart.find( session[:cart_id] )
  rescue
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
