require 'test_helper'

class PlannedRakingEntriesControllerTest < ActionController::TestCase
  setup do
    @planned_raking_entry = planned_raking_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:planned_raking_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create planned_raking_entry" do
    assert_difference('PlannedRakingEntry.count') do
      post :create, planned_raking_entry: { finished: @planned_raking_entry.finished, name: @planned_raking_entry.name, planned_raking_list_id: @planned_raking_entry.planned_raking_list_id, sorting_order: @planned_raking_entry.sorting_order, user_id: @planned_raking_entry.user_id }
    end

    assert_redirected_to planned_raking_entry_path(assigns(:planned_raking_entry))
  end

  test "should show planned_raking_entry" do
    get :show, id: @planned_raking_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @planned_raking_entry
    assert_response :success
  end

  test "should update planned_raking_entry" do
    patch :update, id: @planned_raking_entry, planned_raking_entry: { finished: @planned_raking_entry.finished, name: @planned_raking_entry.name, planned_raking_list_id: @planned_raking_entry.planned_raking_list_id, sorting_order: @planned_raking_entry.sorting_order, user_id: @planned_raking_entry.user_id }
    assert_redirected_to planned_raking_entry_path(assigns(:planned_raking_entry))
  end

  test "should destroy planned_raking_entry" do
    assert_difference('PlannedRakingEntry.count', -1) do
      delete :destroy, id: @planned_raking_entry
    end

    assert_redirected_to planned_raking_entries_path
  end
end
