class InternalTransaction < ApplicationRecord
  def self.eth_inflows(address)
    nonzero_transactions = InternalTransaction.where('lower(internal_transactions.to) = ?', address.downcase).where.not(value: 0).where.not(is_error: true).all
    ids = nonzero_transactions.map {|t| {"hash": t.hash, "value": t.value.to_f / 10.0**18 }}
    puts ids
    nonzero_transactions.map {|t| t.value.to_f }.sum / 10.0**18
  end
  def self.eth_outflows(address)
    nonzero_transactions = InternalTransaction.where('lower(internal_transactions.from) = ?', address.downcase).where.not(value: 0).where.not(is_error: true).all
    ids = nonzero_transactions.map {|t| {"hash": t.hash, "value": t.value.to_f / 10.0**18 }}
    puts ids
    nonzero_transactions.map {|t| t.value.to_f }.sum / 10.0**18
  end
  def self.by_wallet(address)
    InternalTransaction.where('lower(internal_transactions.to) = ?', address.downcase).or(Transaction.where('lower(internal_transactions.from) = ?', address.downcase))
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
