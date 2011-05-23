require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    # this is a call to the fixtures reference (:one is a yaml key)
    @product = products(:one)
    @update = {
      :title => "Loreum Ipsum",
      :description => "Thorny Devils are thorny",
      :image_url => "lorem.jpg",
      :price => 19.95
    }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
    assert_select ".list_description dl dt", products(:one).title
    assert_select ".list_description dl dt", products(:two).title
    assert_select ".list_description dl dt", products(:ruby).title
    assert_select ".list_actions a", "Show"
    assert_select ".list_actions a", "Edit"
    assert_select ".list_actions a", "Destroy"
    assert_select "a[href='#{new_product_path}']", 'New Product'
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select "a[href='#{products_path}']", "Back"
    assert_select "label[for='product_title']", "Title"
    assert_select "#product_title", 1
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, :product => @update
    end

    assert_redirected_to product_path(assigns(:product))
    #~what assert_select's could we do here? - what file test against?
  end

  test "should show product" do
    get :show, :id => @product.to_param
    assert_response :success
    assert_select "p b", "Title:"
    assert_select "a[href='#{edit_product_path(@product)}']", 1
    assert_select "#banner", /Pragmatic Bookshelf/
  end

  test "should get edit" do
    get :edit, :id => @product.to_param
    assert_response :success
  end

  test "should update product" do
    put :update, :id => @product.to_param, :product => @update
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, :id => @product.to_param
    end

    assert_redirected_to products_path
  end
end
