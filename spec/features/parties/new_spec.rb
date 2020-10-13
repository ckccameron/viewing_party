require 'rails_helper'

# As an authenticated user,
# When I visit the new viewing party page,
# I should see a form with the following:
#
#   Movie Title (that is un-editable)
#   Duration of Party with a default value of movie runtime in minutes
#   When: field to select date
#   Start Time: field to select time
#   Checkboxes next to each friend (if user has friends)
#   Button to create a party

describe "As an authenticated user" do
  describe "new party page" do
    before :each do
      @user = create(:user)

      visit login_path
      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_button "Log in"
    end

    it "shows a form with movie title, duration, date and time selectors, checkboxes to select friends and a button to create the party" do
      VCR.use_cassette('fight_club_top_rated_results', allow_playback_repeats: true) do
        VCR.use_cassette('fight_club_details_results', allow_playback_repeats: true) do
          friend1 = create(:user)
          friend2 = create(:user)
          @user.friends << friend1
          @user.friends << friend2

          visit movies_path

          within "#movie-550" do
            click_link "Fight Club"
          end

          expect(current_path).to eq("/movies/550")

          click_button "Create Viewing Party"

          expect(current_path).to eq("/parties/new")

          # expect(page).to have_content("Fight Club")
          expect(page).to have_field(:duration)
          expect(page).to have_css("#party_date_1i")
          expect(page).to have_css("#party_date_2i")
          expect(page).to have_css("#party_date_3i")
          expect(page).to have_css("#party_time_4i")
          expect(page).to have_css("#party_time_5i")
          expect(page).to have_css(".party-friends")

          within ".party-friends" do
            expect(page).to have_unchecked_field(friend1.name)
            expect(page).to have_content(friend1.name)
            expect(page).to have_content(friend1.email)
            expect(page).to have_unchecked_field(friend2.name)
            expect(page).to have_content(friend2.name)
            expect(page).to have_content(friend2.email)
          end

          select "2020", from: "party_date_1i"
          select "October", from: "party_date_2i"
          select "12", from: "party_date_3i"
          # select "10", from: "party_time_4i"
          # select "15", from: "party_time_5i"
          check "#{friend1.name}"
          check "#{friend2.name}"
          click_button "Create This Party"

          expect(current_path).to eq(dashboard_path)

          within ".parties" do
            expect(page).to have_content("Fight Club")
          end
        end
      end
    end
  end
end
