# == Schema Information
# Schema version: 20110429221109
#
# Table name: products
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  description :text
#  image_url   :string(255)
#  price       :decimal(8, 2)
#  created_at  :datetime
#  updated_at  :datetime
#

class Product < ActiveRecord::Base
  # --- default scope --- #
  default_scope :order => 'title'

  # --- validations --- #
  validates :title, :description, :image_url, :presence => true
  validates :title, :uniqueness => true, 
                    :length => {:minimum => 10,
                                :message => "Title MUST have at least 10 characters" }
  validates :image_url, :format => { 
    :with => /\.(jpg|png|gif)$/i,
    :message => "must be a URL for GIF, JPG or PNG"
  } 
  validates :price, :numericality => { 
    :greater_than_or_equal_to => 0.01, 
    :message => "must be at least $0.01" 
  }

end
