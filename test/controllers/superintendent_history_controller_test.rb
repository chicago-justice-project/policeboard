require "test_helper"

class SuperintendentHistoryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get superintendent_history_index_url
    assert_response :success
  end
end
