require 'test_helper'

class AdminAccessTest < ActionDispatch::IntegrationTest
  test "extranet redirects to sign in when unauthenticated" do
    get extranet_cases_path
    assert_redirected_to new_user_session_path
  end

  test "signed-in user can load extranet cases index" do
    sign_in users(:admin)
    get extranet_cases_path
    assert_response :success
  end

  test "signed-in user can load extranet case edit" do
    sign_in users(:admin)
    get edit_extranet_case_path(cases(:decided_active))
    assert_response :success
  end

  test "signed-in user can load extranet rules index" do
    sign_in users(:admin)
    get extranet_rules_path
    assert_response :success
  end

  test "signed-in user can load extranet board members index" do
    sign_in users(:admin)
    get extranet_board_members_path
    assert_response :success
  end
end
