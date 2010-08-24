require 'test_helper'

class Administration::UserHierachiesControllerTest < ActionController::TestCase
  setup do
    @administration_user_hierachy = administration_user_hierachies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administration_user_hierachies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administration_user_hierachy" do
    assert_difference('Administration::UserHierachy.count') do
      post :create, :administration_user_hierachy => @administration_user_hierachy.attributes
    end

    assert_redirected_to administration_user_hierachy_path(assigns(:administration_user_hierachy))
  end

  test "should show administration_user_hierachy" do
    get :show, :id => @administration_user_hierachy.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @administration_user_hierachy.to_param
    assert_response :success
  end

  test "should update administration_user_hierachy" do
    put :update, :id => @administration_user_hierachy.to_param, :administration_user_hierachy => @administration_user_hierachy.attributes
    assert_redirected_to administration_user_hierachy_path(assigns(:administration_user_hierachy))
  end

  test "should destroy administration_user_hierachy" do
    assert_difference('Administration::UserHierachy.count', -1) do
      delete :destroy, :id => @administration_user_hierachy.to_param
    end

    assert_redirected_to administration_user_hierachies_path
  end
end
