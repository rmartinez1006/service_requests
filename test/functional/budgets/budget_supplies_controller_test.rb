require 'test_helper'

class Budgets::BudgetSuppliesControllerTest < ActionController::TestCase
  setup do
    @budgets_budget_supply = budgets_budget_supplies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:budgets_budget_supplies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create budgets_budget_supply" do
    assert_difference('Budgets::BudgetSupply.count') do
      post :create, :budgets_budget_supply => @budgets_budget_supply.attributes
    end

    assert_redirected_to budgets_budget_supply_path(assigns(:budgets_budget_supply))
  end

  test "should show budgets_budget_supply" do
    get :show, :id => @budgets_budget_supply.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @budgets_budget_supply.to_param
    assert_response :success
  end

  test "should update budgets_budget_supply" do
    put :update, :id => @budgets_budget_supply.to_param, :budgets_budget_supply => @budgets_budget_supply.attributes
    assert_redirected_to budgets_budget_supply_path(assigns(:budgets_budget_supply))
  end

  test "should destroy budgets_budget_supply" do
    assert_difference('Budgets::BudgetSupply.count', -1) do
      delete :destroy, :id => @budgets_budget_supply.to_param
    end

    assert_redirected_to budgets_budget_supplies_path
  end
end
