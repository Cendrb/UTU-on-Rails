require 'test_helper'

class AdditionalInfosControllerTest < ActionController::TestCase
  setup do
    @additional_info = additional_infos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:additional_infos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create additional_info" do
    assert_difference('AdditionalInfo.count') do
      post :create, additional_info: { event_id: @additional_info.event_id, exam_id: @additional_info.exam_id, name: @additional_info.name, raking_id: @additional_info.raking_id, task_id: @additional_info.task_id, url: @additional_info.url }
    end

    assert_redirected_to additional_info_path(assigns(:additional_info))
  end

  test "should show additional_info" do
    get :show, id: @additional_info
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @additional_info
    assert_response :success
  end

  test "should update additional_info" do
    patch :update, id: @additional_info, additional_info: { event_id: @additional_info.event_id, exam_id: @additional_info.exam_id, name: @additional_info.name, raking_id: @additional_info.raking_id, task_id: @additional_info.task_id, url: @additional_info.url }
    assert_redirected_to additional_info_path(assigns(:additional_info))
  end

  test "should destroy additional_info" do
    assert_difference('AdditionalInfo.count', -1) do
      delete :destroy, id: @additional_info
    end

    assert_redirected_to additional_infos_path
  end
end
