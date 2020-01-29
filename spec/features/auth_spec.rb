require 'rails_helper'

feature 'Sign Up' do

    background :each do
        visit new_user_path
    end

    scenario 'has a user sign up page' do
        expect(page).to have_content("Sign Up")
    end

    scenario 'takes a username, password, email, and age' do
        expect(page).to have_content("Username:")
    end

    scenario 'redirect to user\'s show and displays username on success' do
        fill_in "Username:", with: "Kevin"
        fill_in "Email:", with: "kev@aa.io"
        fill_in "Password:", with: "password"
        fill_in "Age:", with: 29
        click_button "Sign Up"
        expect(page).to have_content("Kevin")
        user = User.find_by(username: "Kevin")
        debugger
        expect(current_path).to eq(user_path(user))
    end

end