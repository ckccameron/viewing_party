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
end
