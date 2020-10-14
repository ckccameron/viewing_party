require 'rails_helper'

describe 'Welcome page' do
  it "shows a welcome message" do
    welcome = "Welcome to Viewing Party!"
    description = "Viewing Party is the best way to coordinate movie viewing parties with your friends online. Viewing Party allows you to add friends and send them invites to create watch parties. You and your friends can enjoy your favorite movies together."
    visit root_path

    expect(page).to have_content(welcome)
    expect(page).to have_content(description)
  end

  it "has a log in button" do
    visit root_path

    login = "Log in"

    expect(page).to have_button(login)
    click_button(login)
    expect(current_path).to eq("/login")
  end

  it "has a link to register" do
    visit root_path

    register = "Register"

    expect(page).to have_link(register)
    click_link(register)
    expect(current_path).to eq("/register")
  end
end
