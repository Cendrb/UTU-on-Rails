require 'test_helper'

class SgroupsControllerTest < ActionController::TestCase
  setup do
    @sgroup = sgroups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sgroups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sgroup" do
    assert_difference('Sgroup.count') do
      post :create, sgroup: { group_category_id: @sgroup.group_category_id, name: @sgroup.name }
    end

    assert_redirected_to sgroup_path(assigns(:sgroup))
  end

  test "should show sgroup" do
    get :show, id: @sgroup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sgroup
    assert_response :success
  end

  test "should update sgroup" do
    patch :update, id: @sgroup, sgroup: { group_category_id: @sgroup.group_category_id, name: @sgroup.name }
    assert_redirected_to sgroup_path(assigns(:sgroup))
  end

  test "should destroy sgroup" do
    assert_difference('Sgroup.count', -1) do
      delete :destroy, id: @sgroup
    end

    assert_redirected_to sgroups_path
  end
end
