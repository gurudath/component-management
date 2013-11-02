require 'test_helper'

class PagenatesControllerTest < ActionController::TestCase
  setup do
    @pagenate = pagenates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pagenates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pagenate" do
    assert_difference('Pagenate.count') do
      post :create, pagenate: @pagenate.attributes
    end

    assert_redirected_to pagenate_path(assigns(:pagenate))
  end

  test "should show pagenate" do
    get :show, id: @pagenate.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pagenate.to_param
    assert_response :success
  end

  test "should update pagenate" do
    put :update, id: @pagenate.to_param, pagenate: @pagenate.attributes
    assert_redirected_to pagenate_path(assigns(:pagenate))
  end

  test "should destroy pagenate" do
    assert_difference('Pagenate.count', -1) do
      delete :destroy, id: @pagenate.to_param
    end

    assert_redirected_to pagenates_path
  end
end
