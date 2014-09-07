feature "Sign in" do
  given!(:user) { create_user }

  [:username, :email].each do |attr|
    scenario "when account exists, using #{attr.to_s}" do
      # Fill in sign in form
      sign_in login: user.send(attr) do
        expect_page :repertoire
        expect(page).to have_text "Signed in successfully"
      end
    end
  end

  scenario "when account doesn't exist" do
    # Fill in sign in form (with non-existant user)
    sign_in login: "other-user" do
      expect_page :sign_in
      expect(page).to have_text "Invalid email or password"
    end

    # Navigate to sign up
    click_link "Sign up"
    expect_page :sign_up
  end

  scenario "when password is forgotten" do
    # Fill in sign in form (with wrong password)
    sign_in password: "wrong password" do
      expect_page :sign_in
      expect(page).to have_text "Invalid login or password"
    end

    # Fill in password reset request form
    click_link "Forgot your password?"
    expect_page :password_reset_request
    fill_in "Email", with: user.email
    click_button "Send me reset password instructions"

    # Get password reset link from email
    email_body = ActionMailer::Base.deliveries.last.body.to_s
    password_reset_url = email_body[/http([^"\n]+)/]

    # Fill in password reset form
    visit password_reset_url
    expect_page :password_reset
    fill_in "New password",         with: "new password"
    fill_in "Confirm new password", with: "new password"
    click_button "Change my password"

    # Sign in succeeds (implicitly)
    expect_page :repertoire
    expect(page).to have_text "You are now signed in"
  end
end
