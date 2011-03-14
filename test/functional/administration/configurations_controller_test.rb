require 'test_helper'

class Administration::ConfigurationsControllerTest < ActionController::TestCase
  setup do
    @administration_configuration = administration_configurations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administration_configurations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administration_configuration" do
    assert_difference('Administration::Configuration.count') do
      post :create, :administration_configuration => @administration_configuration.attributes
    end

    assert_redirected_to administration_configuration_path(assigns(:administration_configuration))
  end

  test "should show administration_configuration" do
    get :show, :id => @administration_configuration.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @administration_configuration.to_param
    assert_response :success
  end

  test "should update administration_configuration" do
    put :update, :id => @administration_configuration.to_param, :administration_configuration => @administration_configuration.attributes
    assert_redirected_to administration_configuration_path(assigns(:administration_configuration))
  end

  test "should destroy administration_configuration" do
    assert_difference('Administration::Configuration.count', -1) do
      delete :destroy, :id => @administration_configuration.to_param
    end

    assert_redirected_to administration_configurations_path
  end
end
