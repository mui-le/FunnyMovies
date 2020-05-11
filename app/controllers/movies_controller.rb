require 'open-uri'

class MoviesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]

  def index
    @movies = Movies.includes(:user).paginate(page: params[:page])
  end

  def new
    @movie = Movie.new
  end

  def create
    unless valid_url?
      flash[:danger] = "Your url invalid!"
      return redirect_to new_movie_path
    end

    @movie = current_user.movies.build(movie_params)
    if @movie.save
      flash[:success] = "Movie shared!"
      redirect_to root_url
    else
      redirect_to new_movie_path
    end
  end

  private

  def movie_params
    raw_data = get_movie_params
    params[:movie][:title] = raw_data.css('title')&.first&.content&.strip
    params[:movie][:description] = raw_data.search('#watch-description-text')&.first&.content
    params.require(:movie).permit(:url, :title, :description)
  end

  def valid_url?
    params[:movie][:url].match(Movie::URL_REGEXP).present?
  end

  def get_movie_params
    user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"
    Nokogiri::HTML.parse(open(params[:movie][:url], {'User-Agent' => user_agent}), nil, 'UTF-8')
  end
end
