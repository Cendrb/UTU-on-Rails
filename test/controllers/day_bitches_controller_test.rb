require 'test_helper'

class DayBitchesControllerTest < ActionController::TestCase
  setup do
    @day_bitch = day_bitches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:day_bitches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create day_bitch" do
    assert_difference('DayBitch.count') do
      post :create, day_bitch: { bitch_id: @day_bitch.bitch_id, date: @day_bitch.date }
    end

    assert_redirected_to day_bitch_path(assigns(:day_bitch))
  end

  test "should show day_bitch" do
    get :show, id: @day_bitch
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @day_bitch
    assert_response :success
  end

  test "should update day_bitch" do
    patch :update, id: @day_bitch, day_bitch: { bitch_id: @day_bitch.bitch_id, date: @day_bitch.date }
    assert_redirected_to day_bitch_path(assigns(:day_bitch))
  end

  test "should destroy day_bitch" do
    assert_difference('DayBitch.count', -1) do
      delete :destroy, id: @day_bitch
    end

    assert_redirected_to day_bitches_path
  end
end
