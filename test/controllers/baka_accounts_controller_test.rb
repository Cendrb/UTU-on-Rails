require 'test_helper'

class BakaAccountsControllerTest < ActionController::TestCase
  setup do
    @baka_account = baka_accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:baka_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create baka_account" do
    assert_difference('BakaAccount.count') do
      post :create, baka_account: { password: @baka_account.password, username: @baka_account.username }
    end

    assert_redirected_to baka_account_path(assigns(:baka_account))
  end

  test "should show baka_account" do
    get :show, id: @baka_account
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @baka_account
    assert_response :success
  end

  test "should update baka_account" do
    patch :update, id: @baka_account, baka_account: { password: @baka_account.password, username: @baka_account.username }
    assert_redirected_to baka_account_path(assigns(:baka_account))
  end

  test "should destroy baka_account" do
    assert_difference('BakaAccount.count', -1) do
      delete :destroy, id: @baka_account
    end

    assert_redirected_to baka_accounts_path
  end
end
