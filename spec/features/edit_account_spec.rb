feature "Edit account" do
  given!(:user) { create_user }

  background do
    sign_in do
      expect_page :repertoire
    end

    # Navigate to account management
    click_link "Manage account"
    expect_page :edit_account
  end

  scenario "update username" do
    new_username = "new-username"
    fill_in_edit_account username: new_username

    expect_edit_account_success
    expect_can_sign_in_again username: new_username
  end

  scenario "update email" do
    new_email = "new.email@emptyorchestra.co"
    fill_in_edit_account email: new_email

    expect_edit_account_success
    expect_can_sign_in_again email: new_email
  end

  scenario "update password" do
    # Fill in edit account form with new password (but no old password)
    new_password = "new password"
    fill_in_edit_account password: "", new_password: new_password

    # Edit fails (with errors)
    expect_page :edit_account

    within '#error_explanation' do
      expect(page).to have_text "Current password can't be blank"
    end

    # Fill in edit account form with old and new passwords
    fill_in_edit_account new_password: new_password

    expect_edit_account_success
    expect_can_sign_in_again password: new_password
  end

  scenario "delete account", js: true do
    click_button "Cancel my account"
    # NOTE: Poltergeist automatically accepts the confirmation dialog

    # Redirected to home page
    expect_page :home
    expect(page).to have_text "Your account was successfully cancelled"

    # Sign in no longer succeeds
    sign_in do
      expect_page :sign_in
      expect(page).to have_text "Invalid email or password"
    end
  end

  def expect_edit_account_success
    expect_page :repertoire
    expect(page).to have_text "You updated your account successfully"
  end

  def expect_can_sign_in_again(options = {})
    click_link "Sign out"
    sign_in options do
      expect_page :repertoire
    end
  end

  def fill_in_edit_account(options = {})
    options[:username]     ||= user_data[:username]
    options[:email]        ||= user_data[:email]
    options[:password]     ||= user_data[:password]
    options[:new_password] ||= ""

    fill_in "Current password",      with: options[:password]
    fill_in "Password",              with: options[:new_password]
    fill_in "Password confirmation", with: options[:new_password]
    click_button "Update"
  end
end
