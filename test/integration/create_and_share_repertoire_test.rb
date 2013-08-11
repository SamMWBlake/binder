require 'test_helper'

class CreateAndShareRepertoireTest < ActionDispatch::CapybaraIntegrationTest
  test "sign in, view repertoire, add song, view others' repertoires" do
    # Access homepage
    visit "/"
    assert_selector "h1", text: "Empty Orchestra"

    # Sign in
    click_link "Sign in"
    fill_in "Login", with: "sam"
    fill_in "Password", with: "password"
    check "Remember me"
    click_button "Sign in"
    assert_equal "/sam/songs", current_path
    assert_selector ".notice", text: "Signed in successfully."

    # View repertoire
    assert_selector "ul.repertoire"
    assert_selector "ul.repertoire li", count: 3
    assert_selector "ul.repertoire li", text: "Ob-La-Di, Ob-La-Da (The Beatles)"
    assert_selector "ul.repertoire li", text: "Oh! Darling (The Beatles)"
    assert_selector "ul.repertoire li", text: "Thunderstruck (AC/DC)"

    # Add song to repertoire
    click_link "Add song"
    fill_in "Title", with: "The Show Must Go On"
    fill_in "Artist", with: "Queen"
    click_button "Save Song"
    assert_equal "/sam/songs", current_path
    assert_selector "ul.repertoire"
    assert_selector "ul.repertoire li", count: 4
    assert_selector "ul.repertoire li", text: "The Show Must Go On (Queen)"

    # View others' repertoires
    visit "/sarah"
    assert_selector "ul.repertoire"
    assert_selector "ul.repertoire li", count: 1
    assert_selector "ul.repertoire li", text: "Wanted Dead or Alive (Bon Jovi)"
  end
end
