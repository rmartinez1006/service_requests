require 'test_helper'

class Catalogs::RequestStatusesControllerTest < ActionController::TestCase
  setup do
    @catalogs_request_status = catalogs_request_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:catalogs_request_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create catalogs_request_status" do
    assert_difference('Catalogs::RequestStatus.count') do
      post :create, :catalogs_request_status => @catalogs_request_status.attributes
    end

    assert_redirected_to catalogs_request_status_path(assigns(:catalogs_request_status))
  end

  test "should show catalogs_request_status" do
    get :show, :id => @catalogs_request_status.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @catalogs_request_status.to_param
    assert_response :success
  end

  test "should update catalogs_request_status" do
    put :update, :id => @catalogs_request_status.to_param, :catalogs_request_status => @catalogs_request_status.attributes
    assert_redirected_to catalogs_request_status_path(assigns(:catalogs_request_status))
  end

  test "should destroy catalogs_request_status" do
    assert_difference('Catalogs::RequestStatus.count', -1) do
      delete :destroy, :id => @catalogs_request_status.to_param
    end

    assert_redirected_to catalogs_request_statuses_path
  end
end
