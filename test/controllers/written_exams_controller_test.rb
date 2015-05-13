require 'test_helper'

class WrittenExamsControllerTest < ActionController::TestCase
  setup do
    @written_exam = written_exams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:written_exams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create written_exam" do
    assert_difference('WrittenExam.count') do
      post :create, written_exam: {  }
    end

    assert_redirected_to written_exam_path(assigns(:written_exam))
  end

  test "should show written_exam" do
    get :show, id: @written_exam
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @written_exam
    assert_response :success
  end

  test "should update written_exam" do
    patch :update, id: @written_exam, written_exam: {  }
    assert_redirected_to written_exam_path(assigns(:written_exam))
  end

  test "should destroy written_exam" do
    assert_difference('WrittenExam.count', -1) do
      delete :destroy, id: @written_exam
    end

    assert_redirected_to written_exams_path
  end
end
