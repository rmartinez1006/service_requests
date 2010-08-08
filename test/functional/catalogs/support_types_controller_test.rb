require 'test_helper'

class Catalogs::SupportTypesControllerTest < ActionController::TestCase
  setup do
    @catalogs_support_type = catalogs_support_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:catalogs_support_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create catalogs_support_type" do
    assert_difference('Catalogs::SupportType.count') do
      post :create, :catalogs_support_type => @catalogs_support_type.attributes
    end

    assert_redirected_to catalogs_support_type_path(assigns(:catalogs_support_type))
  end

  test "should show catalogs_support_type" do
    get :show, :id => @catalogs_support_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @catalogs_support_type.to_param
    assert_response :success
  end

  test "should update catalogs_support_type" do
    put :update, :id => @catalogs_support_type.to_param, :catalogs_support_type => @catalogs_support_type.attributes
    assert_redirected_to catalogs_support_type_path(assigns(:catalogs_support_type))
  end

  test "should destroy catalogs_support_type" do
    assert_difference('Catalogs::SupportType.count', -1) do
      delete :destroy, :id => @catalogs_support_type.to_param
    end

    assert_redirected_to catalogs_support_types_path
  end
end
