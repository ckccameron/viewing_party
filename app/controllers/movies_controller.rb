class MoviesController < ApplicationController
  before_action :require_login

  def index
    @movies = if params[:query]
                SearchResults.movie_search(params[:query])
              else
                SearchResults.top_rated_movies
              end
  end
end
