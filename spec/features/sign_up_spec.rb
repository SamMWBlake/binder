feature "Sign up" do
  background do
    # Navigate to sign up page
    visit "/"
    click_link "Add your first song"
    expect_page :sign_up
  end

  scenario "with all valid inputs" do
    # Fill in sign up form
    fill_in_sign_up
    click_button "Sign up"

    # Sign up succeeds
    expect_sign_up_success
  end

  scenario "with invalid initial inputs" do
    # Fill in sign up form (with invalid input)
    fill_in_sign_up username: "user.name", email: "u@eo", password: "passwd"
    click_button "Sign up"

    # Redirected to sign up page (with errors)
    expect_page :sign_up
    within '#error_explanation' do
      expect(page).to have_text "Username Invalid (only letters, numbers and hyphens are allowed)"
      expect(page).to have_text "Email is invalid"
      expect(page).to have_text "Password is too short (minimum is 8 characters)"
    end

    # Fill in sign up form again (with valid input)
    fill_in_sign_up
    click_button "Sign up"

    # Sign up succeeds
    expect_sign_up_success
  end

  def expect_sign_up_success
    expect_page :repertoire
    expect(page).to have_text "Welcome! You have signed up successfully"
  end

  def fill_in_sign_up(options = {})
    options[:username] ||= user_data[:username]
    options[:email]    ||= user_data[:email]
    options[:password] ||= user_data[:password]

    fill_in "Username",              with: options[:username]
    fill_in "Email",                 with: options[:email]
    fill_in "Password",              with: options[:password]
    fill_in "Password confirmation", with: options[:password]
  end
end
