feature "View repertoire" do
  given!(:user) { create_user }

  background do
    sign_in
  end

  scenario "own repertoire" do
    add_songs_to_repertoire(user)

    visit "/"

    expect(page).to have_text "Add song"
    expect_repertoire
  end

  scenario "other's repertoire" do
    other_user = create :user

    add_songs_to_repertoire(other_user)

    visit "/users/#{other_user.username}/jams"

    expect_repertoire
  end

  def expect_repertoire
    expect(page).to have_text "AC/DC"
    expect(page).to have_text "Thunderstruck"

    expect(page).to have_text "The Beatles"
    expect(page).to have_text "Norwegian Wood"
    expect(page).to have_text "The Long and Winding Road"
    expect(page).to have_text "Yes It Is"
  end
end
