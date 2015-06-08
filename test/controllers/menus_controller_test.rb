require 'test_helper'

class MenusControllerTest < ActionController::TestCase
  setup do
    @menu = menus(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:menus)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create menu" do
    assert_difference('Menu.count') do
      post :create, menu: { breakfast_head_count: @menu.breakfast_head_count, breakfast_recipe_ids: @menu.breakfast_recipe_ids, breakfast_time: @menu.breakfast_time, dinner_head_count: @menu.dinner_head_count, dinner_recipe_ids: @menu.dinner_recipe_ids, dinner_time: @menu.dinner_time, lunch_head_count: @menu.lunch_head_count, lunch_recipe_ids: @menu.lunch_recipe_ids, lunch_time: @menu.lunch_time, serve_date: @menu.serve_date }
    end

    assert_redirected_to menu_path(assigns(:menu))
  end

  test "should show menu" do
    get :show, id: @menu
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @menu
    assert_response :success
  end

  test "should update menu" do
    patch :update, id: @menu, menu: { breakfast_head_count: @menu.breakfast_head_count, breakfast_recipe_ids: @menu.breakfast_recipe_ids, breakfast_time: @menu.breakfast_time, dinner_head_count: @menu.dinner_head_count, dinner_recipe_ids: @menu.dinner_recipe_ids, dinner_time: @menu.dinner_time, lunch_head_count: @menu.lunch_head_count, lunch_recipe_ids: @menu.lunch_recipe_ids, lunch_time: @menu.lunch_time, serve_date: @menu.serve_date }
    assert_redirected_to menu_path(assigns(:menu))
  end

  test "should destroy menu" do
    assert_difference('Menu.count', -1) do
      delete :destroy, id: @menu
    end

    assert_redirected_to menus_path
  end
end
