require "test_helper"

class TmdbControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get tmdb_show_url
    assert_response :success
  end
end
