require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
  fixtures :products

  setup do
    @line_item = line_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create one line_item" do
    assert_difference('LineItem.count') do
      post :create, :product_id => Product.first.id
    end

    # validate that the price got set on the line_item when it
    # got added to the cart
    cart = Cart.find( session[:cart_id] )
    assert_equal 1, cart.line_items.count
    line_item = cart.line_items.first
    assert_equal Product.first.price, line_item.price

    assert_redirected_to cart_path(assigns(:line_item).cart)
  end

  test "should create two different line_items - one entry in cart" do
    assert_difference('LineItem.count', 2) do
      post :create, :product_id => products(:one).id
      post :create, :product_id => products(:two).id
    end

    # validate that the price got set on the line_item when it
    # got added to the cart
    cart = Cart.find( session[:cart_id] )
    assert_equal 2, cart.line_items.count

    line_item1 = cart.line_items.order(:price).first
    assert_equal 1, line_item1.qty
    assert_equal products(:one).price, line_item1.price

    line_item2 = cart.line_items.order(:price).last
    assert_equal 1, line_item2.qty
    assert_equal products(:two).price, line_item2.price

    assert_redirected_to cart_path(assigns(:line_item).cart)
  end

  test "should create three same line_items - two entries in cart" do
    # qty tracks how many of this line-item are in the cart, do duplicate
    # create requests will only create one new LineItem
    assert_difference('LineItem.count', 1) do
      post :create, :product_id => products(:ruby).id
      post :create, :product_id => products(:ruby).id
      post :create, :product_id => products(:ruby).id
    end

    # validate that the price got set on the line_item when it
    # got added to the cart
    cart = Cart.find( session[:cart_id] )
    assert_equal 1, cart.line_items.count
    line_item = cart.line_items.first
    assert_equal 3, line_item.qty
    assert_equal products(:ruby).price, line_item.price

    assert_redirected_to cart_path(assigns(:line_item).cart)
  end

  test "should show line_item" do
    get :show, :id => @line_item.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @line_item.to_param
    assert_response :success
  end

  test "should update line_item" do
    put :update, :id => @line_item.to_param, :line_item => @line_item.attributes
    assert_redirected_to line_item_path(assigns(:line_item))
  end

  test "should destroy line_item - simple" do
    assert_difference('LineItem.count', -1) do
      delete :destroy, :id => @line_item.to_param
    end

    # after deleting a line item from the cart, you are sent back to the cart
    assert_redirected_to cart_url( Cart.find( session[:cart_id] ) )
  end

  test "should create 3 of same and then delete them with one delete" do
    # --- first create 3 (same as create test above) --- #
    # qty tracks how many of this line-item are in the cart, do duplicate
    # create requests will only create one new LineItem
    assert_difference('LineItem.count', 1) do
      post :create, :product_id => products(:ruby).id
      post :create, :product_id => products(:ruby).id
      post :create, :product_id => products(:ruby).id
    end

    # validate that the price got set on the line_item when it
    # got added to the cart
    cart = Cart.find( session[:cart_id] )
    assert_equal 1, cart.line_items.count

    # --- now delete that one (with qty=3) from this cart --- #    
    assert_difference('LineItem.count', -1) do
      delete :destroy, :id => cart.line_items.first.id
    end
    assert cart.line_items.empty?

    # after deleting a line item from the cart, you are sent back to the cart
    assert_redirected_to cart_url( Cart.find( session[:cart_id] ) )
  end
end
