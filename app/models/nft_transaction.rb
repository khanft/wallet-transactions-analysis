class NftTransaction < ApplicationRecord
  include GenerateCsv
  
  def categories
    TransactionCategorization.where(nft_transaction_id: self.id).map(&:category)
  end
  def self.by_wallet(address)
    NftTransaction.where('lower(nft_transactions.to) = ?', address.downcase).or(NftTransaction.where('lower(nft_transactions.from) = ?', address.downcase))
  end
end
