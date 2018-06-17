require 'test_helper'

class FoodHistoriesControllerTest < ActionController::TestCase
  setup do
    @food_history = food_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:food_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create food_history" do
    assert_difference('FoodHistory.count') do
      post :create, food_history: { detail: @food_history.detail, title: @food_history.title }
    end

    assert_redirected_to food_history_path(assigns(:food_history))
  end

  test "should show food_history" do
    get :show, id: @food_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @food_history
    assert_response :success
  end

  test "should update food_history" do
    patch :update, id: @food_history, food_history: { detail: @food_history.detail, title: @food_history.title }
    assert_redirected_to food_history_path(assigns(:food_history))
  end

  test "should destroy food_history" do
    assert_difference('FoodHistory.count', -1) do
      delete :destroy, id: @food_history
    end

    assert_redirected_to food_histories_path
  end
end
