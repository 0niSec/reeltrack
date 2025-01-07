require "test_helper"

class SignInControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get login_url
    assert_response :success
  end

end
