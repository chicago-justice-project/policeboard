require 'test_helper'

class PublicNavigationTest < ActionDispatch::IntegrationTest
  test "welcome page loads" do
    get root_path
    assert_response :success
  end

  test "cases index loads" do
    get cases_path
    assert_response :success
  end

  test "cases index with search loads" do
    get cases_path, params: { search: "doe" }
    assert_response :success
  end

  test "case show loads for active case" do
    get case_path(cases(:decided_active))
    assert_response :success
  end

  test "case show redirects for inactive case" do
    get case_path(cases(:inactive_hidden))
    assert_redirected_to cases_path
  end

  test "board index loads" do
    get board_index_path
    assert_response :success
  end

  test "rules index loads" do
    get rules_path
    assert_response :success
  end

  test "about page loads" do
    get "/about"
    assert_response :success
  end
end
