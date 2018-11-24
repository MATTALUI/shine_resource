require 'test_helper'

class PresetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get presets_index_url
    assert_response :success
  end

  test "should get show" do
    get presets_show_url
    assert_response :success
  end

  test "should get new" do
    get presets_new_url
    assert_response :success
  end

  test "should get create" do
    get presets_create_url
    assert_response :success
  end

  test "should get edit" do
    get presets_edit_url
    assert_response :success
  end

  test "should get update" do
    get presets_update_url
    assert_response :success
  end

  test "should get destroy" do
    get presets_destroy_url
    assert_response :success
  end

end
