require 'test_helper'

class ServiceTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get service_types_index_url
    assert_response :success
  end

  test "should get show" do
    get service_types_show_url
    assert_response :success
  end

  test "should get new" do
    get service_types_new_url
    assert_response :success
  end

  test "should get create" do
    get service_types_create_url
    assert_response :success
  end

  test "should get edit" do
    get service_types_edit_url
    assert_response :success
  end

  test "should get update" do
    get service_types_update_url
    assert_response :success
  end

  test "should get destroy" do
    get service_types_destroy_url
    assert_response :success
  end

end
