# == Schema Information
# Schema version: 20110525022823
#
# Table name: carts
#
#  id         :integer         not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy

  def add_product(product_id)
    curr_item = line_items.find_by_product_id(product_id)
    if curr_item
      curr_item.qty += 1
    else
      curr_item = line_items.build(:product_id => product_id)
    end
    curr_item
  end

  def total_price
    # Rails defines Array#sum helper that you could also use
    # line_items.to_a.sum { |item| item.total_price }
    line_items.inject(0) { |sum, item| sum + item.total_price }
  end
end
