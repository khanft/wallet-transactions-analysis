require "test_helper"

class TagsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get tags_edit_url
    assert_response :success
  end
end
