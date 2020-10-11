require 'rails_helper'

# As an authenticated user,
# When I visit the movie's detail page,
# I should see
#
#  Button to create a viewing party
# Details This button should take the authenticated user to the new event page
#
# And I should see the following information about the movie:
#
#  Movie Title
#  Vote Average of the movie
#  Runtime in hours & minutes
#  Genere(s) associated to movie
#  Summary description
#  List the first 10 cast members (characters&actress/actors)
#  Count of total reviews
#  Each review's author and information

describe 'As an authenticated user on' do
  describe 'the Movies Details page I should see' do
    before(:each) do
      @user = create(:user)

      visit login_path
      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_button "Log in"
    end

    it "a Button to create a viewing party" do
      VCR.use_cassette("top_40_rated_movies", allow_playback_repeats: true) do
        visit movies_path

        VCR.use_cassette("inception_search_results") do
          fill_in :query, with: "Inception"
          click_button "Search"
          expect(current_path).to eq('/movies')

          page.all('.movie-row').each do |movie|
            expect(movie).to have_content('Inception')
          end

          within('#movie-27205') do
            click_on "Inception"
          end

          expect(current_path).to eq('/movies/27205')

          click_button "Create Viewing Party"
          expect(current_path).to eq('/parties/new')
        end
      end
    end
  end
end
