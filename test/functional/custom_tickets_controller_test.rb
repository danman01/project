require 'test_helper'

class CustomTicketsControllerTest < ActionController::TestCase
  setup do
    @custom_ticket = custom_tickets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:custom_tickets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create custom_ticket" do
    assert_difference('CustomTicket.count') do
      post :create, :custom_ticket => @custom_ticket.attributes
    end

    assert_redirected_to custom_ticket_path(assigns(:custom_ticket))
  end

  test "should show custom_ticket" do
    get :show, :id => @custom_ticket.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @custom_ticket.to_param
    assert_response :success
  end

  test "should update custom_ticket" do
    put :update, :id => @custom_ticket.to_param, :custom_ticket => @custom_ticket.attributes
    assert_redirected_to custom_ticket_path(assigns(:custom_ticket))
  end

  test "should destroy custom_ticket" do
    assert_difference('CustomTicket.count', -1) do
      delete :destroy, :id => @custom_ticket.to_param
    end

    assert_redirected_to custom_tickets_path
  end
end
