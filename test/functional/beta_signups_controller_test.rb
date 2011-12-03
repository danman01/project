require 'test_helper'

class BetaSignupsControllerTest < ActionController::TestCase
  setup do
    @beta_signup = beta_signups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:beta_signups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create beta_signup" do
    assert_difference('BetaSignup.count') do
      post :create, :beta_signup => @beta_signup.attributes
    end

    assert_redirected_to beta_signup_path(assigns(:beta_signup))
  end

  test "should show beta_signup" do
    get :show, :id => @beta_signup.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @beta_signup.to_param
    assert_response :success
  end

  test "should update beta_signup" do
    put :update, :id => @beta_signup.to_param, :beta_signup => @beta_signup.attributes
    assert_redirected_to beta_signup_path(assigns(:beta_signup))
  end

  test "should destroy beta_signup" do
    assert_difference('BetaSignup.count', -1) do
      delete :destroy, :id => @beta_signup.to_param
    end

    assert_redirected_to beta_signups_path
  end
end
