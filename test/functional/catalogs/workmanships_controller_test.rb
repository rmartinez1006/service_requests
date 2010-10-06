require 'test_helper'

class Catalogs::WorkmanshipsControllerTest < ActionController::TestCase
  setup do
    @catalogs_workmanship = catalogs_workmanships(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:catalogs_workmanships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create catalogs_workmanship" do
    assert_difference('Catalogs::Workmanship.count') do
      post :create, :catalogs_workmanship => @catalogs_workmanship.attributes
    end

    assert_redirected_to catalogs_workmanship_path(assigns(:catalogs_workmanship))
  end

  test "should show catalogs_workmanship" do
    get :show, :id => @catalogs_workmanship.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @catalogs_workmanship.to_param
    assert_response :success
  end

  test "should update catalogs_workmanship" do
    put :update, :id => @catalogs_workmanship.to_param, :catalogs_workmanship => @catalogs_workmanship.attributes
    assert_redirected_to catalogs_workmanship_path(assigns(:catalogs_workmanship))
  end

  test "should destroy catalogs_workmanship" do
    assert_difference('Catalogs::Workmanship.count', -1) do
      delete :destroy, :id => @catalogs_workmanship.to_param
    end

    assert_redirected_to catalogs_workmanships_path
  end
end
