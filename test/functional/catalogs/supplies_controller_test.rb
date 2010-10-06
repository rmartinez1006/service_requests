require 'test_helper'

class Catalogs::SuppliesControllerTest < ActionController::TestCase
  setup do
    @catalogs_supply = catalogs_supplies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:catalogs_supplies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create catalogs_supply" do
    assert_difference('Catalogs::Supply.count') do
      post :create, :catalogs_supply => @catalogs_supply.attributes
    end

    assert_redirected_to catalogs_supply_path(assigns(:catalogs_supply))
  end

  test "should show catalogs_supply" do
    get :show, :id => @catalogs_supply.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @catalogs_supply.to_param
    assert_response :success
  end

  test "should update catalogs_supply" do
    put :update, :id => @catalogs_supply.to_param, :catalogs_supply => @catalogs_supply.attributes
    assert_redirected_to catalogs_supply_path(assigns(:catalogs_supply))
  end

  test "should destroy catalogs_supply" do
    assert_difference('Catalogs::Supply.count', -1) do
      delete :destroy, :id => @catalogs_supply.to_param
    end

    assert_redirected_to catalogs_supplies_path
  end
end
