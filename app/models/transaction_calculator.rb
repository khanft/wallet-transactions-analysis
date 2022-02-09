class TransactionCalculator
  def self.calculate_eth_balance address
    tin=Transaction.eth_inflows address
    internalin=InternalTransaction.eth_inflows address
    tout=Transaction.eth_outflows address
    internalout=InternalTransaction.eth_outflows address
    return tin + internalin - tout - internalout
  end
end