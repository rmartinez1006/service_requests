require 'test_helper'

class Requests::ReqDelegationsControllerTest < ActionController::TestCase
  setup do
    @requests_req_delegation = requests_req_delegations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:requests_req_delegations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create requests_req_delegation" do
    assert_difference('Requests::ReqDelegation.count') do
      post :create, :requests_req_delegation => @requests_req_delegation.attributes
    end

    assert_redirected_to requests_req_delegation_path(assigns(:requests_req_delegation))
  end

  test "should show requests_req_delegation" do
    get :show, :id => @requests_req_delegation.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @requests_req_delegation.to_param
    assert_response :success
  end

  test "should update requests_req_delegation" do
    put :update, :id => @requests_req_delegation.to_param, :requests_req_delegation => @requests_req_delegation.attributes
    assert_redirected_to requests_req_delegation_path(assigns(:requests_req_delegation))
  end

  test "should destroy requests_req_delegation" do
    assert_difference('Requests::ReqDelegation.count', -1) do
      delete :destroy, :id => @requests_req_delegation.to_param
    end

    assert_redirected_to requests_req_delegations_path
  end
end
