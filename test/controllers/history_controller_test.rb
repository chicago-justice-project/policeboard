require "test_helper"

class HistoryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get history_index_url
    assert_response :success
  end
end
