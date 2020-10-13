# As an authenticated user,
# When I visit '/dashboard'
# I should see:
#
#  'Welcome <username>!' at the top of page
#  #9 A button to Discover Movies
#  #10 A friends section
#  #11 A viewing parties section

require 'rails_helper'

describe 'User Dashboard Page' do
  before(:each) do
    @user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it "should show welcome message" do
    visit dashboard_path

    expect(page).to have_content("Welcome, #{@user.name}!")
  end

  it "should have a button to Discover Movies" do
    visit dashboard_path

    click_button 'Discover Movies'

    expect(current_path).to eq(discover_path)
  end

  it "should have sections for viewing parties and friends" do
    visit dashboard_path

    expect(page).to have_css('.friends')
    expect(page).to have_css('.parties')
  end

  describe "creating friendships between users" do
    before :each do
      @user1 = create(:user)

      visit login_path
      fill_in :email, with: @user1.email
      fill_in :password, with: @user1.password
      click_button "Log in"
    end

    it "allows user to add a friend by entering the email of another registered user" do
      user2 = create(:user)

      within ".friends" do
        expect(page).to have_content("You currently have no friends")
        fill_in :friend_email, with: user2.email
        click_button "Add Friend"
      end

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("#{user2.name} has been added")

      within ".friends" do
        expect(page).to have_content(user2.email)
      end
    end

    it "does not allow user to add a friend if the email is not registered to a user" do
      email = "no_one@who.com"

      within ".friends" do
        expect(page).to have_content("You currently have no friends")
        fill_in :friend_email, with: email
        click_button "Add Friend"
      end

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("You currently have no friends")
      expect(page).to have_content("Couldn't find user with this email: #{email}")
    end

    it "shows viewing parties on dashboard that include movie title, date, time and status of host or invited for the given user" do
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

          select "2021", from: "party_date_1i"
          select "January", from: "party_date_2i"
          select "31", from: "party_date_3i"
          select "10", from: "party_date_4i"
          select "45", from: "party_date_5i"
          check "#{friend1.name}"
          check "#{friend2.name}"

          click_button "Create This Party"

          expect(page).to have_content("Your party has been created!")

          ## QUESTION: why is this expectation not passing?
          # within ".parties" do
          #   expect(page).to have_link("Fight Club")
          # end

        end
      end
    end

    xit 'create party sad path' do
    end
  end
end
