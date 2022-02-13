load 'app/models/concerns/generate_csv.rb'

class Erc20Transaction < ApplicationRecord
  has_many :transaction_categorizations
  has_many :categories, through: :transaction_categorizations
  include GenerateCSV
  
  WRAPPED_ETHER_CONTRACT_ADDRESS = "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2"

  def self.grouped_by_erc20 address
    tokens = Erc20Transaction.where('lower(erc20_transactions.to) = ?', address.downcase).map(&:token_symbol).uniq
    token_grouping = {}
    tokens.each do |t|
      txs = Erc20Transaction.where('lower(erc20_transactions.to) = ?', address.downcase).or(Erc20Transaction.where('lower(erc20_transactions.from) = ?', address.downcase)).where(token_symbol: t).where.not(value: 0)
      if txs.nil?
        token_grouping[t] = []
      else

        token_grouping[t] = txs
      end
    end
    token_grouping
  end
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
  def flow(address)
    if self.value == 0 
      return 0
    end
    if self.to.downcase == address.downcase
      return self.value.to_f / 10.0**self.token_decimal
    end
    return (self.value.to_f / 10.0**self.token_decimal) * -1
  end
  def self.inflow_by_token(address, token_symbol)
    Erc20Transaction.where('lower(erc20_transactions.to) = ?', address.downcase).where.not(value: 0).where(token_symbol: token_symbol).order(:unixtimestamp)
  end
  def self.synthetic_weth_inflows(address)
    Transaction.where('lower(transactions.from) = ?', address.downcase).where('lower(transactions.to) = ?', WRAPPED_ETHER_CONTRACT_ADDRESS)
  end
  def self.synthetic_weth_outflows(address)
    InternalTransaction.where('lower(internal_transactions.to) = ?', address.downcase).where('lower(internal_transactions.from) = ?', WRAPPED_ETHER_CONTRACT_ADDRESS)
  end
  def self.outflow_by_token(address, token_symbol)
    Erc20Transaction.where('lower(erc20_transactions.from) = ?', address.downcase).where.not(value: 0).where(token_symbol: token_symbol).order(:unixtimestamp)
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
  def self.by_wallet(address)
    Erc20Transaction.where('lower(erc20_transactions.to) = ?', address.downcase).or(Erc20Transaction.where('lower(erc20_transactions.from) = ?', address.downcase))
  end
end
