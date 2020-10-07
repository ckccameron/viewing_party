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

  it "does not allow user to register with a email address that is already in use" do
    user = create(:user)

    visit root_path

    click_link "Register"

    fill_in :name, with: "Consuela"
    fill_in :email, with: user.email
    fill_in :password, with: "123"
    fill_in :password_confirmation, with: "123"

    click_button "Create User"

    expect(page).to have_content("Email has already been taken")
    expect(current_path).to eq("/register")
  end

  it "does not allow user to register if password fields are not matching" do
    visit root_path

    click_link "Register"

    fill_in :name, with: "Consuela"
    fill_in :email, with: "person@gmail.com"
    fill_in :password, with: "123"
    fill_in :password_confirmation, with: "1234"

    click_button "Create User"

    expect(page).to have_content("Password confirmation doesn't match Password")
    expect(current_path).to eq("/register")
  end

  it "displays error messages for blank fields" do
    visit root_path

    click_link "Register"

    fill_in :name, with: ""
    fill_in :email, with: ""
    fill_in :password, with: ""
    fill_in :password_confirmation, with: ""

    click_button "Create User"

    expect(page).to have_content("Name can't be blank, Email can't be blank, Password can't be blank, and Password confirmation doesn't match Password")
    expect(current_path).to eq("/register")
  end
end
