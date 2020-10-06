require 'rails_helper'

describe 'Welcome page' do
  it "shows a welcome message" do
    welcome = "Welcome to watch party!"
    description = "Use this app to coordinate watch parties with your friends."
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
