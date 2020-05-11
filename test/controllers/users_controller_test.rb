require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:lemui)
    @other_user = users(:remitano)
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to root_url
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get :edit, params: { id: @user }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when not logged in" do
    patch :update, params: { id: @user, user: { email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, params: { id: @user }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch :update, params: { id: @user, user: { email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end
end