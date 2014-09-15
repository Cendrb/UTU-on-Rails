require 'test_helper'

class BitchesControllerTest < ActionController::TestCase
  setup do
    @bitch = bitches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bitches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bitch" do
    assert_difference('Bitch.count') do
      post :create, bitch: { description: @bitch.description, group: @bitch.group, name: @bitch.name }
    end

    assert_redirected_to bitch_path(assigns(:bitch))
  end

  test "should show bitch" do
    get :show, id: @bitch
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bitch
    assert_response :success
  end

  test "should update bitch" do
    patch :update, id: @bitch, bitch: { description: @bitch.description, group: @bitch.group, name: @bitch.name }
    assert_redirected_to bitch_path(assigns(:bitch))
  end

  test "should destroy bitch" do
    assert_difference('Bitch.count', -1) do
      delete :destroy, id: @bitch
    end

    assert_redirected_to bitches_path
  end
end
