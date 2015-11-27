require 'test_helper'

class SclassesControllerTest < ActionController::TestCase
  setup do
    @sclass = sclasses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sclasses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sclass" do
    assert_difference('Sclass.count') do
      post :create, sclass: { name: @sclass.name }
    end

    assert_redirected_to sclass_path(assigns(:sclass))
  end

  test "should show sclass" do
    get :show, id: @sclass
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sclass
    assert_response :success
  end

  test "should update sclass" do
    patch :update, id: @sclass, sclass: { name: @sclass.name }
    assert_redirected_to sclass_path(assigns(:sclass))
  end

  test "should destroy sclass" do
    assert_difference('Sclass.count', -1) do
      delete :destroy, id: @sclass
    end

    assert_redirected_to sclasses_path
  end
end
