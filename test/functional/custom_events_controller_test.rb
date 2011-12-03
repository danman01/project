require 'test_helper'

class CustomEventsControllerTest < ActionController::TestCase
  setup do
    @custom_event = custom_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:custom_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create custom_event" do
    assert_difference('CustomEvent.count') do
      post :create, :custom_event => @custom_event.attributes
    end

    assert_redirected_to custom_event_path(assigns(:custom_event))
  end

  test "should show custom_event" do
    get :show, :id => @custom_event.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @custom_event.to_param
    assert_response :success
  end

  test "should update custom_event" do
    put :update, :id => @custom_event.to_param, :custom_event => @custom_event.attributes
    assert_redirected_to custom_event_path(assigns(:custom_event))
  end

  test "should destroy custom_event" do
    assert_difference('CustomEvent.count', -1) do
      delete :destroy, :id => @custom_event.to_param
    end

    assert_redirected_to custom_events_path
  end
end
