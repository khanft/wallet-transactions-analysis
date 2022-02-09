require "test_helper"

class InternalTransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get internal_transactions_index_url
    assert_response :success
  end
end
