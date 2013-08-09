require 'test_helper'

class SongsControllerTest < ActionController::TestCase
  def setup
    @user = users(:sam)
    @other_user = users(:sarah)
    @admin_user = users(:admin)

    @repertoire = @user.songs
    @count_songs = '@repertoire.count'

    sign_in @user
  end

  # index

  test "should show (sorted) list of all songs" do
    sign_out @user
    get :index
    assert_response :success
    refute assigns(:can_add)
    songs = assigns(:songs)
    assert_equal 7, songs.count
    assert_equal "Don't Stop Believin'", songs[0].title
    assert_equal "Flying Teapot",        songs[1].title
    assert_equal "Ob-La-Di, Ob-La-Da",   songs[2].title
    assert_equal "Oh! Darling",          songs[3].title
    assert_equal "Thunderstruck",        songs[4].title
    assert_equal "Waltz for Zizi",       songs[5].title
    assert_equal "Wanted Dead or Alive", songs[6].title
  end

  test "should redirect to list of current user's songs" do
    get :index
    assert_redirected_to user_songs_path(@user)
  end

  test "should show (sorted) list of current user's songs" do
    get :index, user_id: @user.id
    assert_response :success
    assert assigns(:can_add)
    songs = assigns(:songs)
    assert_equal 3, songs.count
    assert_equal "Ob-La-Di, Ob-La-Da", songs[0].title
    assert_equal "Oh! Darling",        songs[1].title
    assert_equal "Thunderstruck",      songs[2].title
  end

  test "should show (sorted) list of other user's songs" do
    get :index, user_id: @other_user.id
    assert_response :success
    refute assigns(:can_add)
    songs = assigns(:songs)
    assert_equal 1, songs.count
    assert_equal "Wanted Dead or Alive", songs[0].title
  end

  test "should get (sorted) list of all songs starting with 'o'" do
    get :index, starts_with: 'o'
    assert_response :success
    songs = JSON.parse @response.body
    assert_equal songs.count, 2
    assert_equal "Ob-La-Di, Ob-La-Da", songs[0]['title']
    assert_equal "Oh! Darling",        songs[1]['title']
  end

  # new

  test "should show new song form for current user" do
    get :new, user_id: @user.id
    assert_response :success
  end

  test "new should redirect to song list for other user" do
    get :new, user_id: @other_user.id
    assert_redirected_to user_songs_path(@other_user)
  end

  # create

  test "should not create repertoire entry if it already exists" do
    song = songs(:standard)
    assert @repertoire.include? song
    assert_no_difference(@count_songs) do
      post :create, song: {title: song.title, artist: song.artist.name}, user_id: @user.id
    end
    assert @repertoire.include? song
    assert_redirected_to user_songs_path(@user)
  end

  test "should create repertoire entry if it doesn't exist" do
    song = songs(:overplayed)
    refute @repertoire.include? song
    assert_difference(@count_songs) do
      post :create, song: {title: song.title, artist: song.artist.name}, user_id: @user.id
    end
    assert @repertoire.include? song
    assert_redirected_to user_songs_path(@user)
  end

  test "create should redirect to song list for other user" do
    song = songs(:overplayed)
    post :create, song: {title: song.title, artist: song.artist.name}, user_id: @other_user.id
    assert_redirected_to user_songs_path(@other_user)
  end

  # destroy

  test "should destroy repertoire_song if it exists" do
    song = songs(:standard)
    assert @repertoire.include? song
    assert_difference(@count_songs, -1) do
      delete :destroy, id: song.id, user_id: @user.id
    end
    refute @repertoire.include? song
    assert_redirected_to user_songs_path(@user)
  end

  test "should do nothing if repertoire_song doesn't exist to be destroyed" do
    song = songs(:overplayed)
    refute @repertoire.include? song
    assert_no_difference(@count_songs) do
      delete :destroy, id: song.id, user_id: @user.id
    end
    refute @repertoire.include? song
    assert_redirected_to user_songs_path(@user)
  end

  test "destroy should redirect to song list for other user" do
    song = songs(:overplayed)
    delete :destroy, id: song.id, user_id: @other_user.id
    assert_redirected_to user_songs_path(@other_user)
  end
end
