load 'scripts/etherscan.rb'

class ScrapableAddress < ApplicationRecord
  def transactions
    Transaction.by_wallet self.address
  end
  def internal_transactions
    InternalTransaction.by_wallet self.address
  end
  def nft_transactions
    NftTransaction.by_wallet self.address
  end
  def erc20_transactions
    Erc20Transaction.by_wallet self.address
  end
  def scrape!
    eapi = EtherscanAPI.new self.address
    eapi.parse_all
  end
  def total_gas_used
    if self.is_hot_wallet
      Transaction.where('lower(transactions.from) = ?', self.address.downcase).map {|tx| tx.gas_used * tx.gas_price / 10.0**18 }.sum
    else
      0
    end
  end
end
