class TransactionCategorization < ApplicationRecord
  belongs_to :category
  validates :category_id, uniqueness: { scope: [:transaction_id, :internal_transaction_id, :nft_transaction_id, :erc20_transaction_id],
    message: "should only have one tag per transaction" }
  
end
