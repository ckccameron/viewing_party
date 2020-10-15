require 'rails_helper'

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

          click_button "Create Viewing Party"

          expect(current_path).to eq("/parties/new")

          expect(page).to have_field(:duration)
          expect(page).to have_css("#party_date_1i")
          expect(page).to have_css("#party_date_2i")
          expect(page).to have_css("#party_date_3i")
          expect(page).to have_css("#party_date_4i")
          expect(page).to have_css("#party_date_5i")
          expect(page).to have_css(".party-friends")

          within ".party-friends" do
            expect(page).to have_unchecked_field(friend1.name)
            expect(page).to have_content(friend1.name)
            expect(page).to have_content(friend1.email)
            expect(page).to have_unchecked_field(friend2.name)
            expect(page).to have_content(friend2.name)
            expect(page).to have_content(friend2.email)
          end

          select "2021", from: "party_date_1i"
          select "January", from: "party_date_2i"
          select "31", from: "party_date_3i"
          select "10", from: "party_date_4i"
          select "45", from: "party_date_5i"
          check "#{friend1.name}"
          check "#{friend2.name}"

          click_button "Create This Party"

          expect(current_path).to eq(dashboard_path)
          expect(page).to have_content("Your party has been created!")
        end
      end
    end

    it "does not create a party with missing info", :vcr do
      friend1 = create(:user)
      friend2 = create(:user)
      @user.friends << friend1
      @user.friends << friend2

      visit movies_path

      within "#movie-550" do
        click_link "Fight Club"
      end

      click_button "Create Viewing Party"

      expect(current_path).to eq("/parties/new")

      select "2019", from: "party_date_1i"
      select "January", from: "party_date_2i"
      select "31", from: "party_date_3i"
      select "10", from: "party_date_4i"
      select "45", from: "party_date_5i"
      check "#{friend1.name}"
      check "#{friend2.name}"

      click_button "Create This Party"

      expect(current_path).to eq(parties_new_path)
      expect(page).to have_content("Datetime must be on or after")
    end
  end
end
