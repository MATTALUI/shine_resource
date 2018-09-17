require 'test_helper'

class MemosControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get memos_show_url
    assert_response :success
  end

  test "should get create" do
    get memos_create_url
    assert_response :success
  end

  test "should get destroy" do
    get memos_destroy_url
    assert_response :success
  end

end
