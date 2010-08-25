require 'test_helper'

class Administration::UsersControllerTest < ActionController::TestCase
  setup do
    @administration_user = administration_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administration_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administration_user" do
    assert_difference('Administration::User.count') do
      post :create, :administration_user => @administration_user.attributes
    end

    assert_redirected_to administration_user_path(assigns(:administration_user))
  end

  test "should show administration_user" do
    get :show, :id => @administration_user.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @administration_user.to_param
    assert_response :success
  end

  test "should update administration_user" do
    put :update, :id => @administration_user.to_param, :administration_user => @administration_user.attributes
    assert_redirected_to administration_user_path(assigns(:administration_user))
  end

  test "should destroy administration_user" do
    assert_difference('Administration::User.count', -1) do
      delete :destroy, :id => @administration_user.to_param
    end

    assert_redirected_to administration_users_path
  end
end
