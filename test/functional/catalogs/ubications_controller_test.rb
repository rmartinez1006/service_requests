require 'test_helper'

class Catalogs::UbicationsControllerTest < ActionController::TestCase
  setup do
    @catalogs_ubication = catalogs_ubications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:catalogs_ubications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create catalogs_ubication" do
    assert_difference('Catalogs::Ubication.count') do
      post :create, :catalogs_ubication => @catalogs_ubication.attributes
    end

    assert_redirected_to catalogs_ubication_path(assigns(:catalogs_ubication))
  end

  test "should show catalogs_ubication" do
    get :show, :id => @catalogs_ubication.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @catalogs_ubication.to_param
    assert_response :success
  end

  test "should update catalogs_ubication" do
    put :update, :id => @catalogs_ubication.to_param, :catalogs_ubication => @catalogs_ubication.attributes
    assert_redirected_to catalogs_ubication_path(assigns(:catalogs_ubication))
  end

  test "should destroy catalogs_ubication" do
    assert_difference('Catalogs::Ubication.count', -1) do
      delete :destroy, :id => @catalogs_ubication.to_param
    end

    assert_redirected_to catalogs_ubications_path
  end
end
