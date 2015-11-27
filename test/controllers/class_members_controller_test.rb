require 'test_helper'

class ClassMembersControllerTest < ActionController::TestCase
  setup do
    @class_member = class_members(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:class_members)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create class_member" do
    assert_difference('ClassMember.count') do
      post :create, class_member: { first_name: @class_member.first_name, last_name: @class_member.last_name, sclass_id: @class_member.sclass_id }
    end

    assert_redirected_to class_member_path(assigns(:class_member))
  end

  test "should show class_member" do
    get :show, id: @class_member
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @class_member
    assert_response :success
  end

  test "should update class_member" do
    patch :update, id: @class_member, class_member: { first_name: @class_member.first_name, last_name: @class_member.last_name, sclass_id: @class_member.sclass_id }
    assert_redirected_to class_member_path(assigns(:class_member))
  end

  test "should destroy class_member" do
    assert_difference('ClassMember.count', -1) do
      delete :destroy, id: @class_member
    end

    assert_redirected_to class_members_path
  end
end
