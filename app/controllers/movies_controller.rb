class MoviesController < ApplicationController
  before_action :require_login

  def index
    if params[:query]
      @movies = SearchResults.movie_search(params[:query])
    else
      @movies = SearchResults.top_rated_movies
    end
  end
end
