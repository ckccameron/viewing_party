require 'rails_helper'

describe "user registration" do
  it "allows a new user to register and logs them in" do
    visit root_path

    click_link "Register"

    expect(current_path).to eq("/register")

    name = "Consuela"
    email = "person@gmail.com"
    password = "password123"
    password_confirmation = "password123"

    fill_in :name, with: name
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation

    click_button "Create User"

    expect(page).to have_content("Welcome, #{name}!")
    expect(current_path).to eq("/dashboard")
  end
end
