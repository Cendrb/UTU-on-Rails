require 'test_helper'

class DetailsAccessesControllerTest < ActionController::TestCase
  setup do
    @details_access = details_accesses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:details_accesses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create details_access" do
    assert_difference('DetailsAccess.count') do
      post :create, details_access: { ip_address: @details_access.ip_address, user_agent: @details_access.user_agent, user_id: @details_access.user_id }
    end

    assert_redirected_to details_access_path(assigns(:details_access))
  end

  test "should show details_access" do
    get :show, id: @details_access
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @details_access
    assert_response :success
  end

  test "should update details_access" do
    patch :update, id: @details_access, details_access: { ip_address: @details_access.ip_address, user_agent: @details_access.user_agent, user_id: @details_access.user_id }
    assert_redirected_to details_access_path(assigns(:details_access))
  end

  test "should destroy details_access" do
    assert_difference('DetailsAccess.count', -1) do
      delete :destroy, id: @details_access
    end

    assert_redirected_to details_accesses_path
  end
end
