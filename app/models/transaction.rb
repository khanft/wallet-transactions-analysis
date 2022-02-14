class Transaction < ApplicationRecord
  has_many :transaction_categorizations
  has_many :categories, through: :transaction_categorizations
  include GenerateCSV
  
  def self.by_wallet(address)
    Transaction.where('lower(transactions.to) = ?', address.downcase).or(Transaction.where('lower(transactions.from) = ?', address.downcase))
  end
  def self.eth_inflows(address)
    nonzero_transactions = Transaction.where('lower(transactions.to) = ?', address.downcase).where.not(value: 0).where.not(is_error: true).all
    ids = nonzero_transactions.map {|t| {"hash": t.hash, "value": t.value.to_f / 10.0**18 }}
    puts ids
    nonzero_transactions.map {|t| t.value.to_f }.sum / 10.0**18
  end
  def self.eth_outflows(address)
    nonzero_transactions = Transaction.where('lower(transactions.from) = ?', address.downcase).where.not(value: 0).where.not(is_error: true).all
    ids = nonzero_transactions.map {|t| {"hash": t.hash, "value": t.value.to_f / 10.0**18 }}
    puts ids
    nonzero_transactions.map {|t| t.value.to_f }.sum / 10.0**18
  end
  def self.total_gas_used(address)
    txs = Transaction.where('lower(transactions.from) = ?', address.downcase)
    ids = txs.map {|t| {"hash": t.hash, "value": t.gas_used.to_f / 10.0**18 }}
    puts ids
    txs.map {|t| t.gas_used.to_f }.sum / 10.0**18
  end

  def flow(address)
    if self.value == 0 
      return 0
    end
    if self.to.downcase == address.downcase
      return self.value.to_f / 10.0**18
    end
    return (self.value.to_f / 10.0**18) * -1
  end

end
