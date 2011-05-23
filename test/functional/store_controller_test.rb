require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select '#columns #side a', :minimum => 4
    assert_select '#main .entry', 3
    assert_select 'h3', Product.first.title
    assert_select 'h3', Product.last.title
    assert_select '.price', /\$[,\d+]\.\d{2}/
  end

end
