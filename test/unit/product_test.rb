require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # this deletes all data from the products table and then
  # loads the sample data in fixtures/products.yml into the test DB
  fixtures :products

  setup do
    @product = Product.new(:title => "Atlas Hiccuped",
                           :description => "Book by Ryn Aand",
                           :image_url => "aand.jpg",
                           :price => 1.95)
  end

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end

  test "product price must be positive" do
    assert @product.valid?

    @product.price = -1
    assert @product.invalid?
    assert @product.errors[:price].join =~ /must be at least.*0.01/i
    
    @product.price = 0
    assert @product.invalid?
    assert @product.errors[:price].join =~ /must be at least.*0.01/i
  end

  test "image url" do
    ary_good = %w(fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif)
    ary_bad = %w( no-suffix fred.doc fred.gif/more fred.gif.more )

    ary_good.each do |val|
      @product.image_url = val
      assert @product.valid?, "#{val} should be valid"
    end

    ary_bad.each do |val|
      @product.image_url = val
      assert @product.invalid?,  "#{val} should be invalid"
    end
  end

  test "product must have unique title" do
    assert @product.valid?
    assert @product.errors[:title].empty?
    @product.title = products(:ruby).title # this retrieves the 'ruby' 
                                           # entry from the products fixture
    assert @product.invalid?
    assert !@product.save
    assert @product.errors[:title].any?
    assert_equal( I18n.translate('activerecord.errors.messages.taken'),
                  @product.errors[:title].join )

  end
  
end
