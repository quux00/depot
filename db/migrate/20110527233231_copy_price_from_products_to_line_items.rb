class CopyPriceFromProductsToLineItems < ActiveRecord::Migration
  def self.up
    LineItem.all.each do |item|
      item.price = item.product.price
      item.save  # this should do an update
    end
  end

  def self.down
    LineItem.all.each do |item|
      item.price = nil
      item.save  # this should do an update
    end    
  end
end
