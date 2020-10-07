require 'rails_helper'

describe "As an authenticated user" do
  describe 'the Discover Page' do
    before(:each) do
      @user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
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
end
