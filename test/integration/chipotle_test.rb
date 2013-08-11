require 'test_helper'

class ChipotleTest < ActionDispatch::IntegrationTest
  test "Chipotle redirection" do
    get "/burrito"
    assert_chipotle!
    get "/burritos"
    assert_chipotle!
    get "/tacos"
    assert_chipotle!
  end

  private
    def assert_chipotle!
      chipotle_destination = "https://order.chipotle.com/"
      assert_redirected_to chipotle_destination
      follow_redirect!
      assert_equal chipotle_destination, request.url
      assert_response :success
    end
end
