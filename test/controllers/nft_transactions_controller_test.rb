require "test_helper"

class NftTransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get nft_transactions_index_url
    assert_response :success
  end
end
