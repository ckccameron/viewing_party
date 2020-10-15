require 'rails_helper'

describe 'As an authenticated user on' do
  describe 'the Movies Details page I should see' do
    before(:each) do
      @user = create(:user)

      visit login_path
      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_button "Log in"
    end

    it "a Button to create a viewing party", :vcr do
      visit movies_path

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

    it "movie info, details, cast and reviews", :vcr do
      visit movies_path

      fill_in :query, with: "Fight Club"
      click_button "Search"
      expect(current_path).to eq('/movies')

      within('#movie-550') do
        click_on "Fight Club"
      end
      expect(current_path).to eq('/movies/550')

      expect(page).to have_css(".movie-title")
      title = find(".movie-title").text
      expect(title).not_to be_empty

      expect(page).to have_css(".movie-vote-average")
      vote_average = find(".movie-vote-average").text
      expect(vote_average).not_to be_empty

      expect(page).to have_css(".movie-runtime")
      runtime = find(".movie-runtime").text
      expect(runtime).not_to be_empty

      expect(page).to have_css(".movie-genres")
      genres = find(".movie-genres").text
      expect(genres).not_to be_empty

      expect(page).to have_css(".movie-overview")
      overview = find(".movie-overview").text
      expect(overview).not_to be_empty

      expect(page).to have_css(".movie-review-count")
      review_count = find(".movie-review-count").text
      expect(review_count).not_to be_empty

      expect(page).to have_css(".movie-cast")
      cast = page.all(".movie-cast")
      expect(cast.first.text).not_to be_empty
      expect(cast.size).to eq(10)

      expect(page).to have_css(".movie-review")
      review = page.all(".movie-review").first.text
      expect(review).not_to be_empty
    end


    it "also displays movie poster and video for the movie" do
      VCR.use_cassette("fight_club_top_rated_results", allow_playback_repeats: true) do
        visit movies_path

        fill_in :query, with: "Fight Club"
        click_button "Search"
        expect(current_path).to eq('/movies')

        within('#movie-550') do
          click_on "Fight Club"
        end
        expect(current_path).to eq('/movies/550')

        expect(page).to have_css(".movie-poster")
        expect(page).to have_css("img[src*='https://image.tmdb.org/t/p/w185/jSziioSwPVrOy9Yow3XhWIBDjq1.jpg']")
        expect(page).to have_css(".movie-video")
      end
    end
  end
end
