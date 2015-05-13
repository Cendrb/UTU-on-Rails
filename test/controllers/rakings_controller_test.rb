require 'test_helper'

class RakingsControllerTest < ActionController::TestCase
  setup do
    @raking = rakings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rakings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create raking" do
    assert_difference('Raking.count') do
      post :create, raking: { description: @raking.description, end: @raking.end, name: @raking.name, subject_id: @raking.subject_id }
    end

    assert_redirected_to raking_path(assigns(:raking))
  end

  test "should show raking" do
    get :show, id: @raking
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @raking
    assert_response :success
  end

  test "should update raking" do
    patch :update, id: @raking, raking: { description: @raking.description, end: @raking.end, name: @raking.name, subject_id: @raking.subject_id }
    assert_redirected_to raking_path(assigns(:raking))
  end

  test "should destroy raking" do
    assert_difference('Raking.count', -1) do
      delete :destroy, id: @raking
    end

    assert_redirected_to rakings_path
  end
end
