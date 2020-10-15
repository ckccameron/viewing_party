class PartiesController < ApplicationController
  before_action :require_login

  def new
    id = params[:movie_id]
    @movie = SearchResults.party_details(id)
  end

  def create
    attributes = Party.format_params(params)
    @party = Party.new(attributes)
    if @party.save
      flash[:success] = 'Your party has been created!'
      Guest.create_invites(params, current_user, @party)
      redirect_to dashboard_path
    else
      flash[:error] = @party.errors.full_messages.to_sentence
      redirect_to parties_new_path
    end
  end

  ## QUESTION: How could we use strong params here? are the class methods here conventional?
end
