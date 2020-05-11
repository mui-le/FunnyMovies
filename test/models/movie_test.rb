require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  def setup
    @user = users(:lemui)
    @movie = @user.movies.build(url: "https://www.remitano.com", title: "title sample", description: 'description sample')
  end

  test "should be valid" do
    assert @movie.valid?
  end

  test "user id should be valid" do
    @movie.user_id = nil
    assert_not @movie.valid?
  end

  test "url should be present" do
    @movie.url = "   "
    assert_not @movie.valid?
  end

  test "url should be at most 500 characters" do
    @movie.url = "a" * 501
    assert_not @movie.valid?
  end

  test "title should be valid" do
    @movie.title = nil
    assert_not @movie.valid?
  end

  test "title should be present" do
    @movie.title = "   "
    assert_not @movie.valid?
  end

  test "title should be at most 140 characters" do
    @movie.title = "a" * 141
    assert_not @movie.valid?
  end

  test "description should be valid" do
    @movie.description = nil
    assert_not @movie.valid?
  end

  test "description should be present" do
    @movie.description = "   "
    assert_not @movie.valid?
  end

end
