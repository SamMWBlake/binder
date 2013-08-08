require 'test_helper'

class SongsControllerTest < ActionController::TestCase
  def setup
    @user = users(:sam)
    @repertoire = @user.songs
    @count_songs = '@repertoire.count'
  end

  test "should not create repertoire entry if it already exists" do
    @song = songs(:standard)
    assert @repertoire.include? @song
    assert_no_difference(@count_songs) do
      post :create, song: {id: @song.id}, user_id: @user.id
    end
    assert @repertoire.include? @song
    assert_redirected_to user_songs_path(@user)
  end

  test "should create repertoire entry if it doesn't exist" do
    @song = songs(:overplayed)
    refute @repertoire.include? @song
    assert_difference(@count_songs) do
      post :create, song: {id: @song.id}, user_id: @user.id
    end
    assert @repertoire.include? @song
    assert_redirected_to user_songs_path(@user)
  end

  test "should destroy repertoire_song if it exists" do
    @song = songs(:standard)
    assert @repertoire.include? @song
    assert_difference(@count_songs, -1) do
      delete :destroy, id: @song.id, user_id: @user.id
    end
    refute @repertoire.include? @song
    assert_redirected_to user_songs_path(@user)
  end

  test "should do nothing if repertoire_song doesn't exist to be destroyed" do
    @song = songs(:overplayed)
    refute @repertoire.include? @song
    assert_no_difference(@count_songs) do
      delete :destroy, id: @song.id, user_id: @user.id
    end
    refute @repertoire.include? @song
    assert_redirected_to user_songs_path(@user)
  end
end
