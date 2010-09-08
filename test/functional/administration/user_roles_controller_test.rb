require 'test_helper'

class Administration::UserRolesControllerTest < ActionController::TestCase
  setup do
    @administration_user_role = administration_user_roles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administration_user_roles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administration_user_role" do
    assert_difference('Administration::UserRole.count') do
      post :create, :administration_user_role => @administration_user_role.attributes
    end

    assert_redirected_to administration_user_role_path(assigns(:administration_user_role))
  end

  test "should show administration_user_role" do
    get :show, :id => @administration_user_role.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @administration_user_role.to_param
    assert_response :success
  end

  test "should update administration_user_role" do
    put :update, :id => @administration_user_role.to_param, :administration_user_role => @administration_user_role.attributes
    assert_redirected_to administration_user_role_path(assigns(:administration_user_role))
  end

  test "should destroy administration_user_role" do
    assert_difference('Administration::UserRole.count', -1) do
      delete :destroy, :id => @administration_user_role.to_param
    end

    assert_redirected_to administration_user_roles_path
  end
end
