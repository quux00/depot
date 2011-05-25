class StoreController < ApplicationController
  def index
    @products = Product.all
    @currtime = current_time
    if session[:counter].nil?
      @cart_count = session[:counter] = 1
    else
      @cart_count = session[:counter] += 1
    end
  end


  # helper method
  #~TODO: probably should go into a Helper class ...
  def current_time
    Time.now.strftime("%d-%b-%Y %I:%M%p")
  end

end
