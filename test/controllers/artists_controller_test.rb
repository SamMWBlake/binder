require 'test_helper'

class ArtistsControllerTest < ActionController::TestCase
  # index

  test "should get (sorted) list of all artists" do
    get :index
    assert_response :success
    artists = JSON.parse @response.body
    assert_equal artists.count, 5
    assert_equal "AC/DC",         artists[0]['name']
    assert_equal "Bon Jovi",      artists[1]['name']
    assert_equal "Journey",       artists[2]['name']
    assert_equal "The Beatles",   artists[3]['name']
    assert_equal "The Seatbelts", artists[4]['name']
  end

  test "should get (sorted) list of all artists starting with 't'" do
    get :index, starts_with: 't'
    assert_response :success
    artists = JSON.parse @response.body
    assert_equal artists.count, 2
    assert_equal "The Beatles",   artists[0]['name']
    assert_equal "The Seatbelts", artists[1]['name']
  end
end
