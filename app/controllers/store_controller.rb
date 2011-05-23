class StoreController < ApplicationController
  def index
    @products = Product.all
    @currtime = current_time
  end


  # helper method
  #~TODO: probably should go into a Helper class ...
  def current_time
    Time.now.strftime("%d-%b-%Y %I:%M%p")
  end

end
