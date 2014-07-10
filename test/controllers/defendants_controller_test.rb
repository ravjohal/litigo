require 'test_helper'

class DefendantsControllerTest < ActionController::TestCase
  setup do
    @defendant = defendants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:defendants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create defendant" do
    assert_difference('Defendant.count') do
      post :create, defendant: { employed: @defendant.employed, felony_convictions: @defendant.felony_convictions, job_description: @defendant.job_description, jury_likeability: @defendant.jury_likeability, last_ten_years: @defendant.last_ten_years, married: @defendant.married, parent: @defendant.parent, salary: @defendant.salary }
    end

    assert_redirected_to defendant_path(assigns(:defendant))
  end

  test "should show defendant" do
    get :show, id: @defendant
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @defendant
    assert_response :success
  end

  test "should update defendant" do
    patch :update, id: @defendant, defendant: { employed: @defendant.employed, felony_convictions: @defendant.felony_convictions, job_description: @defendant.job_description, jury_likeability: @defendant.jury_likeability, last_ten_years: @defendant.last_ten_years, married: @defendant.married, parent: @defendant.parent, salary: @defendant.salary }
    assert_redirected_to defendant_path(assigns(:defendant))
  end

  test "should destroy defendant" do
    assert_difference('Defendant.count', -1) do
      delete :destroy, id: @defendant
    end

    assert_redirected_to defendants_path
  end
end
