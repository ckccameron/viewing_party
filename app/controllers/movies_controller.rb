class MoviesController < ApplicationController
  before_action :require_login

  def index
    @movies = SearchResults.top_rated_movies
  end
end
