require 'rails_helper'

describe "user login" do
  it "allows returning user to login" do
    user = create(:user)

    visit root_path

    click_button "Log in"

    expect(current_path).to eq("/login")

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_button "Log in"

    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("Welcome, #{user.name}")
    expect(page).to have_button("Log out")
    expect(page).to_not have_button("Log in")
  end
end
