require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get timeline" do
    get user_timeline_url
    assert_response :success
  end

end
