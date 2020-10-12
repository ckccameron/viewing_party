class PartiesController < ApplicationController
  before_action :require_login

  def new
    id = params[:movie_id]
    @movie = SearchResults.party_details(id)
  end
end
