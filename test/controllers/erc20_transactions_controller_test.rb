require "test_helper"

class Erc20TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get erc20_transactions_index_url
    assert_response :success
  end
end
