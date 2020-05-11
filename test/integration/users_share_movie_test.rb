require 'test_helper'

class UsersShareMovieTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:lemui)
    @movie = movies(:first)
  end

  test "share movie with invalid information" do
    log_in_as(@user)
    get new_movie_path
    assert_no_difference 'Movie.count' do
      post movies_path, params: { movie: {url: ''} }
    end
    assert_not flash.empty?
    follow_redirect!
    assert_template 'movies/new'
  end

  test "share movie with valid information" do
    log_in_as(@user)
    get new_movie_path
    assert_difference 'Movie.count', 1 do
      post movies_path, params: { movie: {url: @movie.url} }
    end
    assert_not flash.empty?
    follow_redirect!
    assert_template 'static_pages/home'
  end
end