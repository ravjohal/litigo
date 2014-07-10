require 'test_helper'

class PlantiffsControllerTest < ActionController::TestCase
  setup do
    @plantiff = plantiffs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:plantiffs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create plantiff" do
    assert_difference('Plantiff.count') do
      post :create, plantiff: { employed: @plantiff.employed, felony_convictions: @plantiff.felony_convictions, job_description: @plantiff.job_description, jury_likeability: @plantiff.jury_likeability, last_ten_years: @plantiff.last_ten_years, married: @plantiff.married, parent: @plantiff.parent, salary: @plantiff.salary }
    end

    assert_redirected_to plantiff_path(assigns(:plantiff))
  end

  test "should show plantiff" do
    get :show, id: @plantiff
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @plantiff
    assert_response :success
  end

  test "should update plantiff" do
    patch :update, id: @plantiff, plantiff: { employed: @plantiff.employed, felony_convictions: @plantiff.felony_convictions, job_description: @plantiff.job_description, jury_likeability: @plantiff.jury_likeability, last_ten_years: @plantiff.last_ten_years, married: @plantiff.married, parent: @plantiff.parent, salary: @plantiff.salary }
    assert_redirected_to plantiff_path(assigns(:plantiff))
  end

  test "should destroy plantiff" do
    assert_difference('Plantiff.count', -1) do
      delete :destroy, id: @plantiff
    end

    assert_redirected_to plantiffs_path
  end
end
