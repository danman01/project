require 'test_helper'

class LookingForsControllerTest < ActionController::TestCase
  setup do
    @looking_for = looking_fors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:looking_fors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create looking_for" do
    assert_difference('LookingFor.count') do
      post :create, :looking_for => @looking_for.attributes
    end

    assert_redirected_to looking_for_path(assigns(:looking_for))
  end

  test "should show looking_for" do
    get :show, :id => @looking_for.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @looking_for.to_param
    assert_response :success
  end

  test "should update looking_for" do
    put :update, :id => @looking_for.to_param, :looking_for => @looking_for.attributes
    assert_redirected_to looking_for_path(assigns(:looking_for))
  end

  test "should destroy looking_for" do
    assert_difference('LookingFor.count', -1) do
      delete :destroy, :id => @looking_for.to_param
    end

    assert_redirected_to looking_fors_path
  end
end
