require 'test_helper'

class ExternalActionsControllerTest < ActionController::TestCase
  test "should get pre_data" do
    get :pre_data
    assert_response :success
  end

  test "should get data" do
    get :data
    assert_response :success
  end

end
