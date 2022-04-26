require "test_helper"

class SuperHistoryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get super_history_index_url
    assert_response :success
  end
end
