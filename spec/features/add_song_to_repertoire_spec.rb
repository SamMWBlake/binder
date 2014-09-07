feature "Add song to repertoire" do
  given!(:user) { create_user }

  background do
    sign_in
  end

  scenario "add song", js: true do
    create_songs

    # Navigate to Add song page
    visit "/"
    click_link "Add song"
    expect_page :add_song

    # Activate song autocomplete
    find_field("Song title").native.send_keys "Th"
    within '.ui-autocomplete' do
      expect(page).to have_text "The Long and Winding Road"
      expect(page).to have_text "Thunderstruck"

      expect(page).to have_no_text "Norwegian Wood"
      expect(page).to have_no_text "Yes It Is"
    end

    # Select desired completion
    within '.ui-autocomplete' do
      find('a', text: "Thunderstruck").click
    end
    expect(find_field("Song title").value).to eq "Thunderstruck"
    expect(find_field("Artist name").value).to eq "AC/DC"

    # Add song
    click_button "Save Jam"
    expect_page :repertoire
    expect(page).to have_text "AC/DC"
    expect(page).to have_text "Thunderstruck"
  end
end
