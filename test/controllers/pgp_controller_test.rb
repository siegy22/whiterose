require "test_helper"

class PgpControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get pgp_edit_url
    assert_response :success
  end

  test "should get update" do
    get pgp_update_url
    assert_response :success
  end
end
