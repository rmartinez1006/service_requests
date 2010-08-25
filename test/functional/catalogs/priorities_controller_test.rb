require 'test_helper'

class Catalogs::PrioritiesControllerTest < ActionController::TestCase
  setup do
    @catalogs_priority = catalogs_priorities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:catalogs_priorities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create catalogs_priority" do
    assert_difference('Catalogs::Priority.count') do
      post :create, :catalogs_priority => @catalogs_priority.attributes
    end

    assert_redirected_to catalogs_priority_path(assigns(:catalogs_priority))
  end

  test "should show catalogs_priority" do
    get :show, :id => @catalogs_priority.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @catalogs_priority.to_param
    assert_response :success
  end

  test "should update catalogs_priority" do
    put :update, :id => @catalogs_priority.to_param, :catalogs_priority => @catalogs_priority.attributes
    assert_redirected_to catalogs_priority_path(assigns(:catalogs_priority))
  end

  test "should destroy catalogs_priority" do
    assert_difference('Catalogs::Priority.count', -1) do
      delete :destroy, :id => @catalogs_priority.to_param
    end

    assert_redirected_to catalogs_priorities_path
  end
end
