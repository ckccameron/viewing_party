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
  end
end
