require "test_helper"

class StreetsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get streets_show_url
    assert_response :success
  end

  test "should get index" do
    get streets_index_url
    assert_response :success
  end

  test "should get edit" do
    get streets_edit_url
    assert_response :success
  end

  test "should get delete" do
    get streets_delete_url
    assert_response :success
  end
end
