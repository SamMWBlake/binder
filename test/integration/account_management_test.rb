require 'test_helper'

class AccountManagementTest < ActionDispatch::CapybaraIntegrationTest
  test "sign up, change username, sign out" do
    # Access homepage
    visit "/"
    assert_equal "/", current_path

    # Sign up
    click_link "Create account"
    fill_in "Username", with: "heather"
    fill_in "Email", with: "heather@zombo.com"
    fill_in "Password", with: "password"
    click_button "Sign up"
    assert_equal "/heather/songs", current_path
    assert_selector ".notice", text: "Welcome! You have signed up successfully."

    # Access homepage with current user redirect
    visit "/"
    assert_equal "/heather/songs", current_path

    # Change username
    click_link "Manage account"
    fill_in "Username", with: "adelle"
    fill_in "Current password", with: "password"
    click_button "Update"
    assert_equal "/adelle/songs", current_path
    assert_selector ".notice", text: "You updated your account successfully."    

    # Access homepage with current user redirect
    visit "/"
    assert_equal "/adelle/songs", current_path

    # Sign out
    click_link "Sign out"
    assert_equal "/", current_path
    assert_selector ".notice", text: "Signed out successfully."

    # Access homepage
    visit "/"
    assert_equal "/", current_path
  end
end
