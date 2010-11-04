require 'test_helper'

class Budgets::BudgetsControllerTest < ActionController::TestCase
  setup do
    @budgets_budget = budgets_budgets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:budgets_budgets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create budgets_budget" do
    assert_difference('Budgets::Budget.count') do
      post :create, :budgets_budget => @budgets_budget.attributes
    end

    assert_redirected_to budgets_budget_path(assigns(:budgets_budget))
  end

  test "should show budgets_budget" do
    get :show, :id => @budgets_budget.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @budgets_budget.to_param
    assert_response :success
  end

  test "should update budgets_budget" do
    put :update, :id => @budgets_budget.to_param, :budgets_budget => @budgets_budget.attributes
    assert_redirected_to budgets_budget_path(assigns(:budgets_budget))
  end

  test "should destroy budgets_budget" do
    assert_difference('Budgets::Budget.count', -1) do
      delete :destroy, :id => @budgets_budget.to_param
    end

    assert_redirected_to budgets_budgets_path
  end
end
