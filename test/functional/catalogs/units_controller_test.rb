require 'test_helper'

class Catalogs::UnitsControllerTest < ActionController::TestCase
  setup do
    @catalogs_unit = catalogs_units(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:catalogs_units)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create catalogs_unit" do
    assert_difference('Catalogs::Unit.count') do
      post :create, :catalogs_unit => @catalogs_unit.attributes
    end

    assert_redirected_to catalogs_unit_path(assigns(:catalogs_unit))
  end

  test "should show catalogs_unit" do
    get :show, :id => @catalogs_unit.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @catalogs_unit.to_param
    assert_response :success
  end

  test "should update catalogs_unit" do
    put :update, :id => @catalogs_unit.to_param, :catalogs_unit => @catalogs_unit.attributes
    assert_redirected_to catalogs_unit_path(assigns(:catalogs_unit))
  end

  test "should destroy catalogs_unit" do
    assert_difference('Catalogs::Unit.count', -1) do
      delete :destroy, :id => @catalogs_unit.to_param
    end

    assert_redirected_to catalogs_units_path
  end
end
