class StaticPagesController < ApplicationController

  def home
    @movies = Movie.includes(:user).paginate(page: params[:page], per_page: 5)
  end
end