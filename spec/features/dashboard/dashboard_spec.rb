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

    visit login_path
    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    click_button "Log in"
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
      friend1 = create(:user)
      friend2 = create(:user)
      friend3 = create(:user)
      friend4 = create(:user)

      party1 = create(:party)
      party2 = create(:party)
      party3 = create(:party)

      create(:guest, party_id: party1.id, user_id: @user1.id, is_host: true)
      create(:guest, party_id: party2.id, user_id: @user1.id, is_host: false)

      visit dashboard_path

      within ".parties" do
        expect(page).to have_link(party1.movie_title)
        expect(page).to have_link(party2.movie_title)
        expect(page).to have_css(".hosting-party-row")
        expect(page).to have_css(".guest-party-row")
      end
    end

    it 'displays zero parties message to user if they have no parties that they are hosting or invited to' do
      visit dashboard_path

      within ".parties" do
        expect(page).to have_content("You have zero parties")
      end
    end
  end
end
