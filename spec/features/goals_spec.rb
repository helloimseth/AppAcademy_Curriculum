require 'spec_helper'
require 'rails_helper'

# CRUD
# Private/public
# Goal Text
# Notes
# User_id
# Completed?


feature "Creating a goal" do

  scenario "cant create goal unless signed in" do
    visit new_goal_url
    expect(page).to have_content "Bonjour Le Log In Page"
  end

  scenario "has a new goal page" do
    sign_up_user('Bobby', 'password')
    visit new_goal_url
    expect(page).to have_content('Get your goal on!')
  end

  scenario "user is redirected to own show page on completion" do
    user = sign_up_user('Bobby', 'password')
    visit new_goal_url
    fill_in('Title', with: 'Lose Five Pounds')
    choose('Public')
    click_button("Let's do it")
    expect(page).to have_content("~~Mah Profile~~")
  end

  scenario "goal is added to user's show page" do
    user = sign_up_user('Bobby', 'password')
    visit new_goal_url
    fill_in('Title', with: 'Lose Five Pounds')
    choose('Public')
    click_button("Let's do it")
    expect(page).to have_content('Lose Five Pounds')
  end
end

feature "displaying goals on user#show page" do

  scenario "only display current user's private goals" do
    user1 = sign_up_user('Bobby', 'password')
    visit new_goal_url
    fill_in('Title', with: 'Lose Five Pounds')
    choose('Private')
    click_button("Let's do it")
    click_button('Log Out')

    user2 = sign_up_user('Jill', 'password')
    visit user_url(user1)

    expect(page).to_not have_content('Lose Five Pounds')
  end

  scenario "have a link to new goal" do
    user1 = sign_up_user('Bobby', 'password')
    click_button("Get Rockin'")
    expect(page).to have_content('Get your goal on!')
  end
end

feature "displaying goals on goal#index page" do
  scenario "button to return to current user's show page" do
    user = sign_up_user('Bobby', 'password')
    visit goals_url
    click_button("Mah Profile")
    expect(page).to have_content("~~Mah Profile~~")
  end

  scenario "must be signed in to view goals" do
    visit goals_url
    expect(page).to have_content "Bonjour Le Log In Page"
  end

  scenario "displaying other peoples goals" do
    user1 = sign_up_user('Bobby', 'password')
    visit new_goal_url
    fill_in('Title', with: 'Lose Five Pounds')
    choose('Public')
    click_button("Let's do it")
    click_button('Log Out')

    user2 = sign_up_user('Jill', 'password')
    visit goals_url

    expect(page).to have_content('Lose Five Pounds')
  end

  scenario "display goal owner (Bobby)" do
    user1 = sign_up_user('Bobby', 'password')
    visit new_goal_url
    fill_in('Title', with: 'Lose Five Pounds')
    choose('Public')
    click_button("Let's do it")
    visit goals_url
    expect(page).to have_content('Bobby')
  end

  scenario "goal links to goal owner's show page" do
    user1 = sign_up_user('Bobby', 'password')
    visit new_goal_url
    fill_in('Title', with: 'Lose Five Pounds')
    choose('Public')
    click_button("Let's do it")
    visit goals_url
    click_link('Bobby')
    expect(page).to have_content('Bobby')
  end
end

feature "editing a goal" do
  scenario "can't edit unless signed in" do
    user1 = sign_up_user('Bobby', 'password')
    visit new_goal_url
    fill_in('Title', with: 'Lose Five Pounds')
    choose('Public')
    click_button("Let's do it")
    click_button('Log Out')
    visit edit_goal_url(Goal.first)
    expect(page).to have_content "Bonjour Le Log In Page"
  end

  scenario "form autocompletes existing attributes" do
    user1 = sign_up_user('Bobby', 'password')
    visit new_goal_url
    fill_in('Title', with: 'Lose Five Pounds')
    choose('Public')
    click_button("Let's do it")
    visit edit_goal_url(Goal.first)
    expect(page).to have_content('Lose Five Pounds')
  end

  scenario "can't edit other peoples goals" do
    user1 = sign_up_user('Bobby', 'password')
    visit new_goal_url
    fill_in('Title', with: 'Lose Five Pounds')
    choose('Public')
    click_button("Let's do it")
    click_button('Log Out')

    user2 = sign_up_user('Jill', 'password')
    visit edit_goal_url(Goal.first)
    expect(page).to have_content("Bobby")
  end

end

feature "destroying a goal" do

  scenario "redirects to user show page on completion" do
    user1 = sign_up_user('Bobby', 'password')
    visit new_goal_url
    fill_in('Title', with: 'Lose Five Pounds')
    choose('Public')
    click_button("Let's do it")
    click_button("Delete")
    expect(page).to have_content('~~Mah Profile~~')
  end

  scenario "delete button only appears for goal owner" do
    user1 = sign_up_user('Bobby', 'password')
    visit new_goal_url
    fill_in('Title', with: 'Lose Five Pounds')
    choose('Public')
    click_button("Let's do it")
    click_button('Log Out')

    user2 = sign_up_user('Jill', 'password')
    visit user_url(user1)
    expect(page).to_not have_content('Delete')
  end

  scenario "remove from display upon deletion" do
    user1 = sign_up_user('Bobby', 'password')
    visit new_goal_url
    fill_in('Title', with: 'Lose Five Pounds')
    choose('Public')
    click_button("Let's do it")
    click_button("Delete")
    expect(page).to_not have_content('Lose Five Pounds')
  end

end
