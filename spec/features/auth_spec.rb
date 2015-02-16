require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Bonjour Le Sign Up Page"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in('Username', with: 'raddude33')
      fill_in('Password', with: 'kiracohen1')
      click_button('Sign Up')
    end

    scenario "shows username on the homepage after signup" do
      expect(page).to have_content('raddude33')
    end

  end

end

feature "logging in" do

  it "shows username on the homepage after login"

end

feature "logging out" do

  it "begins with logged out state"

  it "doesn't show username on the homepage after logout"

end
