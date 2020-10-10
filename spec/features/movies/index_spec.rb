require 'rails_helper'

describe 'As an authenticated user' do
  describe 'the Movies Index Page' do
    before(:each) do
      @user = create(:user)

      visit login_path
      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_button "Log in"
    end

    it "should have a button to discover top 40 movies" do
      VCR.use_cassette("top_40_rated_movies", allow_playback_repeats: true) do
        visit movies_path

        click_button "Discover Top 40 Movies"
        expect(current_path).to eq('/movies')
      end
    end

    it "should have a search bar for movies" do
      VCR.use_cassette("top_40_rated_movies", allow_playback_repeats: true) do
        visit movies_path
        VCR.use_cassette("inception_search_results") do
          fill_in :query, with: "Inception"
          click_button "Search"
          expect(current_path).to eq('/movies')
          page.all('.movie-row').each do |movie|
            expect(movie).to have_content('Inception')
          end
        end
      end
    end

    it "shows top 40 rated movies when I click Discover button" do
      VCR.use_cassette("top_40_rated_movies", allow_playback_repeats: true) do
        visit movies_path

        click_button "Discover Top 40 Movies"

        expect(page).to have_css('.top-rated')
        expect(page).to have_css('.movie-row', count: 40)

        within(first('.movie-row')) do
          expect(page).to have_link("Gabriel's Inferno Part II")
          expect(page).to have_content(8.9)
        end
      end
    end

    it "shows a no results message if there are no matching results" do
      json_response = File.read("spec/fixtures/empty_body_for_top_rated_movies.json")

      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV["TMDB_API_KEY"]}&page=1").to_return(status: 200, body: json_response, headers: {})

      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV["TMDB_API_KEY"]}&page=2").to_return(status: 200, body: json_response, headers: {})

      visit movies_path

      expect(page).to have_content("No matching results.")
      expect(page).to_not have_css(".movie-row")
    end
  end
end
