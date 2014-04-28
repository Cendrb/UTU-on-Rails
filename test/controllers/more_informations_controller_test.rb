require 'test_helper'

class MoreInformationsControllerTest < ActionController::TestCase
  setup do
    @more_information = more_informations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:more_informations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create more_information" do
    assert_difference('MoreInformation.count') do
      post :create, more_information: { name: @more_information.name, url: @more_information.url }
    end

    assert_redirected_to more_information_path(assigns(:more_information))
  end

  test "should show more_information" do
    get :show, id: @more_information
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @more_information
    assert_response :success
  end

  test "should update more_information" do
    patch :update, id: @more_information, more_information: { name: @more_information.name, url: @more_information.url }
    assert_redirected_to more_information_path(assigns(:more_information))
  end

  test "should destroy more_information" do
    assert_difference('MoreInformation.count', -1) do
      delete :destroy, id: @more_information
    end

    assert_redirected_to more_informations_path
  end
end
