require 'test_helper'

class Requests::SupportRequestsControllerTest < ActionController::TestCase
  setup do
    @requests_support_request = requests_support_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:requests_support_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create requests_support_request" do
    assert_difference('Requests::SupportRequest.count') do
      post :create, :requests_support_request => @requests_support_request.attributes
    end

    assert_redirected_to requests_support_request_path(assigns(:requests_support_request))
  end

  test "should show requests_support_request" do
    get :show, :id => @requests_support_request.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @requests_support_request.to_param
    assert_response :success
  end

  test "should update requests_support_request" do
    put :update, :id => @requests_support_request.to_param, :requests_support_request => @requests_support_request.attributes
    assert_redirected_to requests_support_request_path(assigns(:requests_support_request))
  end

  test "should destroy requests_support_request" do
    assert_difference('Requests::SupportRequest.count', -1) do
      delete :destroy, :id => @requests_support_request.to_param
    end

    assert_redirected_to requests_support_requests_path
  end
end
