require 'test_helper'

class Requests::RequestCommentariesControllerTest < ActionController::TestCase
  setup do
    @requests_request_commentary = requests_request_commentaries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:requests_request_commentaries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create requests_request_commentary" do
    assert_difference('Requests::RequestCommentary.count') do
      post :create, :requests_request_commentary => @requests_request_commentary.attributes
    end

    assert_redirected_to requests_request_commentary_path(assigns(:requests_request_commentary))
  end

  test "should show requests_request_commentary" do
    get :show, :id => @requests_request_commentary.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @requests_request_commentary.to_param
    assert_response :success
  end

  test "should update requests_request_commentary" do
    put :update, :id => @requests_request_commentary.to_param, :requests_request_commentary => @requests_request_commentary.attributes
    assert_redirected_to requests_request_commentary_path(assigns(:requests_request_commentary))
  end

  test "should destroy requests_request_commentary" do
    assert_difference('Requests::RequestCommentary.count', -1) do
      delete :destroy, :id => @requests_request_commentary.to_param
    end

    assert_redirected_to requests_request_commentaries_path
  end
end
