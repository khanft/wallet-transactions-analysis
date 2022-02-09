class Erc20Transaction < ApplicationRecord
  def self.inflows(address)
    transactions = Erc20Transaction.where('lower(erc20_transactions.to) = ?', address.downcase).where.not(value: 0).all
    unprocessed_data = {}
    transactions.each do |tx|
      if unprocessed_data[tx.token_symbol].present?
        unprocessed_data[tx.token_symbol].append(tx)
      else
        unprocessed_data[tx.token_symbol] = [tx]
      end
    end
    data = {}
    unprocessed_data.each do |k, v| 
      inflow = v.map {|tx| tx.value / 10.0 ** tx.token_decimal}.sum
      if data[k].present?
        data[k] += inflow
      else
        data[k] = inflow
      end
    end
    return data
  end
  def self.outflows(address)
    transactions = Erc20Transaction.where('lower(erc20_transactions.from) = ?', address.downcase).where.not(value: 0).all
    unprocessed_data = {}
    transactions.each do |tx|
      if unprocessed_data[tx.token_symbol].present?
        unprocessed_data[tx.token_symbol].append(tx)
      else
        unprocessed_data[tx.token_symbol] = [tx]
      end
    end
    data = {}
    unprocessed_data.each do |k, v| 
      outf = v.map {|tx| tx.value / 10.0 ** tx.token_decimal}.sum
      if data[k].present?
        data[k] += outf
      else
        data[k] = outf
      end
    end
    return data
  end
end
