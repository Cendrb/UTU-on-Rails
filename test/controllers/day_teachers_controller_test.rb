require 'test_helper'

class DayTeachersControllerTest < ActionController::TestCase
  setup do
    @day_teacher = day_teachers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:day_teachers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create day_teacher" do
    assert_difference('DayTeacher.count') do
      post :create, day_teacher: { teacher_id: @day_teacher.teacher_id, date: @day_teacher.date }
    end

    assert_redirected_to day_teacher_path(assigns(:day_teacher))
  end

  test "should show day_teacher" do
    get :show, id: @day_teacher
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @day_teacher
    assert_response :success
  end

  test "should update day_teacher" do
    patch :update, id: @day_teacher, day_teacher: { teacher_id: @day_teacher.teacher_id, date: @day_teacher.date }
    assert_redirected_to day_teacher_path(assigns(:day_teacher))
  end

  test "should destroy day_teacher" do
    assert_difference('DayTeacher.count', -1) do
      delete :destroy, id: @day_teacher
    end

    assert_redirected_to day_teachers_path
  end
end
