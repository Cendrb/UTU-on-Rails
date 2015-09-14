require 'test_helper'

class PlannedRakingListsControllerTest < ActionController::TestCase
  setup do
    @planned_raking_list = planned_raking_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:planned_raking_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create planned_raking_list" do
    assert_difference('PlannedRakingList.count') do
      post :create, planned_raking_list: { beginning: @planned_raking_list.beginning, description: @planned_raking_list.description, subject_id: @planned_raking_list.subject_id, title: @planned_raking_list.title }
    end

    assert_redirected_to planned_raking_list_path(assigns(:planned_raking_list))
  end

  test "should show planned_raking_list" do
    get :show, id: @planned_raking_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @planned_raking_list
    assert_response :success
  end

  test "should update planned_raking_list" do
    patch :update, id: @planned_raking_list, planned_raking_list: { beginning: @planned_raking_list.beginning, description: @planned_raking_list.description, subject_id: @planned_raking_list.subject_id, title: @planned_raking_list.title }
    assert_redirected_to planned_raking_list_path(assigns(:planned_raking_list))
  end

  test "should destroy planned_raking_list" do
    assert_difference('PlannedRakingList.count', -1) do
      delete :destroy, id: @planned_raking_list
    end

    assert_redirected_to planned_raking_lists_path
  end
end
