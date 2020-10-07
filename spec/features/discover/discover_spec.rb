require 'rails_helper'

describe "As an authenticated user" do
  describe 'the Discover Page' do
    before(:each) do
      @user = create(:user)

      visit login_path
      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_button "Log in"
    end

    it "should have a button to discover top 40 movies" do
      visit discover_path

      click_button "Discover Top 40 Movies"
      expect(current_path).to eq('/movies')
    end

    it "should have a search bar for movies" do
      visit discover_path

      fill_in :query, with: "My movie"
      click_button "Search"
      expect(current_path).to eq('/movies')
    end
  end

describe 'As un-authenticated user' do
  it "I cannot see the discover page" do
    user = create(:user)
    visit discover_path

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end

end