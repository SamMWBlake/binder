def add_songs_to_repertoire(user)
  user.add_song_to_repertoire "Thunderstruck", "AC/DC"
  user.add_song_to_repertoire "Norwegian Wood", "The Beatles"
  user.add_song_to_repertoire "The Long and Winding Road", "The Beatles"
  user.add_song_to_repertoire "Yes It Is", "The Beatles"
end

def create_songs
  acdc    = create :artist, name: "AC/DC"
  beatles = create :artist, name: "The Beatles"

  create :song, artist: beatles, title: "Norwegian Wood"
  create :song, artist: beatles, title: "The Long and Winding Road"
  create :song, artist: acdc,    title: "Thunderstruck"
  create :song, artist: beatles, title: "Yes It Is"
end

def create_user
  user = create :user, user_data
end

def expect_h2(text)
  within 'h2' do
    expect_text text
  end
end

def expect_text(text)
  expect(page).to have_text text
end

def expect_page(page)
  case page
  when :add_song               then expect_text "Song title"
  when :edit_account           then expect_text "Edit User"
  when :home                   then expect_text "What's your jam?"
  when :password_reset         then expect_h2 "Change your password"
  when :password_reset_request then expect_h2 "Forgot your password?"
  when :repertoire             then expect_text "Add song"
  when :sign_in                then expect_h2 "Sign in"
  when :sign_up                then expect_text "Sign up"
  else expect_h2 page
  end
end

def sign_in(options = {})
  options[:login]    ||= user_data[:email]
  options[:password] ||= user_data[:password]

  # Go to sign in page via the home page
  visit "/"
  click_link "or sign in to your existing repertoire"
  expect_page :sign_in

  # Fill in sign in form
  fill_in "Login",    with: options[:login]
  fill_in "Password", with: options[:password]
  check "Remember me"
  click_button "Sign in"

  yield if block_given?
end

def user_data
  { username: "user", email: "user@emptyorchestra.co", password: "password" }
end
