require 'test_helper'

class Catalogs::CommentTypesControllerTest < ActionController::TestCase
  setup do
    @catalogs_comment_type = catalogs_comment_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:catalogs_comment_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create catalogs_comment_type" do
    assert_difference('Catalogs::CommentType.count') do
      post :create, :catalogs_comment_type => @catalogs_comment_type.attributes
    end

    assert_redirected_to catalogs_comment_type_path(assigns(:catalogs_comment_type))
  end

  test "should show catalogs_comment_type" do
    get :show, :id => @catalogs_comment_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @catalogs_comment_type.to_param
    assert_response :success
  end

  test "should update catalogs_comment_type" do
    put :update, :id => @catalogs_comment_type.to_param, :catalogs_comment_type => @catalogs_comment_type.attributes
    assert_redirected_to catalogs_comment_type_path(assigns(:catalogs_comment_type))
  end

  test "should destroy catalogs_comment_type" do
    assert_difference('Catalogs::CommentType.count', -1) do
      delete :destroy, :id => @catalogs_comment_type.to_param
    end

    assert_redirected_to catalogs_comment_types_path
  end
end
