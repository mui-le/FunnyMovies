require 'test_helper'

class MoviesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:lemui)
    @movie = movies(:first)
  end

  test "should redirect to root path when not logged in" do
    get new_movie_path
    assert_redirected_to root_url
  end

  test "share action should redirect to root path when not logged in" do
    post movies_path, params: { movie: @movie }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should get new" do
    log_in_as(@user)
    get new_movie_path
    assert_response :success
  end

  test "share action should success" do
    post movies_path, params: { movie: @movie }
    assert_not flash.empty?
    assert_redirected_to root_url
  end
end
