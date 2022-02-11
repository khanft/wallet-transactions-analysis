class EtherscanAPI
  MAINNET_DEFAULT_CONNECT_OPTIONS = {
    open_timeout: 10,
    read_timeout: 70,
    parse_result: true,
    url: "https://api.etherscan.io/api",
  }
  MAINNET_ETHERSCAN = Web3::Eth::Etherscan.new(ENV["ETHERSCAN_API_KEY"], connect_options: MAINNET_DEFAULT_CONNECT_OPTIONS)


  def initialize(address)
    @address = address
  end

  def get_transactions
    begin
    MAINNET_ETHERSCAN.account_txlist(@address)
    rescue Exception => e
      return []
    end
  end

  def get_internal_transactions
    begin
    MAINNET_ETHERSCAN.account_txlistinternal(@address)
    rescue Exception => e
      return []
    end
  end

  def get_nft_transactions
    begin
    MAINNET_ETHERSCAN.account_tokennfttx(@address)
    rescue Exception => e
      return []
    end
  end

  def get_erc20_transactions
    begin
    MAINNET_ETHERSCAN.account_tokentx(address: @address, start_block: 0)
    rescue Exception => e
      return []
    end
  end
  def get_balance
    begin
    MAINNET_ETHERSCAN.account_balance(@address)
    rescue Exception => e
      return []
    end
  end

  def parse_all
    parse_erc20_transactions
    parse_nft_transactions
    parse_internal_transactions
    parse_transactions
  end


  def parse_erc20_transactions
    txs = get_erc20_transactions
    txs.each do |tx|
      erc20_tx = Erc20Transaction.where(hash: tx["hash"], token_symbol: tx["tokenSymbol"], value: tx["value"], from: tx["from"], to: tx["to"], contract_address: tx["contractAddress"]).first
      if erc20_tx.nil?
        hsh = tx["hash"]
        bn = tx["blockNumber"]
        ts = tx["timeStamp"]
        begin
          erc20_tx = Erc20Transaction.create(
            hash: hsh,
            block_number: bn,
            unixtimestamp: ts,
            block_hash: tx["blockHash"],
            from: tx["from"],
            contract_address: tx["contractAddress"],
            to: tx["to"],
            value: tx["value"],
            token_name: tx["tokenName"],
            token_symbol: tx["tokenSymbol"],
            token_decimal: tx["tokenDecimal"],
            gas: tx["gas"],
            gas_used: tx["gasUsed"],
            gas_price: tx["gasPrice"],
            cumulative_gas_used: tx["cumulativeGasUsed"])
        rescue Exception => e
          # for some reason we can save but this returns an error
          puts e
        end
      end
    end
  end
  def parse_nft_transactions
    txs = get_nft_transactions
    counter = 0
    txs.each do |tx|
      puts counter, tx
      counter+=1
      erc20_tx = NftTransaction.where(hash: tx["hash"], token_id: tx["tokenID"], to: tx["to"], from: tx["from"]).first
      if erc20_tx.nil?
        # create 
        hsh = tx["hash"]
        bn = tx["blockNumber"]
        ts = tx["timeStamp"]
        begin
          erc20_tx = NftTransaction.create(
            hash: hsh,
            block_number: bn,
            unixtimestamp: ts,
            block_hash: tx["blockHash"],
            from: tx["from"],
            contract_address: tx["contractAddress"],
            to: tx["to"],
            token_id: tx["tokenID"],
            token_name: tx["tokenName"],
            token_symbol: tx["tokenSymbol"],
            token_decimal: tx["tokenDecimal"],
            gas: tx["gas"],
            gas_used: tx["gasUsed"],
            gas_price: tx["gasPrice"],
            cumulative_gas_used: tx["cumulativeGasUsed"])
        rescue Exception => e
          # for some reason we can save but this returns an error
          puts e
        end
      else
        puts "EXISTS #{counter} \n\n#{tx}\n\n #{erc20_tx.to_json}\n-----------"
      end
    end
  end
  def parse_internal_transactions
    txs = get_internal_transactions
    counter = 0
    txs.each do |tx|
      puts counter, tx
      counter+=1
      internal_tx = InternalTransaction.where(hash: tx["hash"], to: tx["to"], trace_id: tx["traceId"], from: tx["from"]).first
      if internal_tx.nil?
        # create 
        hsh = tx["hash"]
        bn = tx["blockNumber"]
        ts = tx["timeStamp"]
        begin
          internal_tx = InternalTransaction.create(
            hash: hsh,
            block_number: bn,
            unixtimestamp: ts,
            from: tx["from"],
            contract_address: tx["contractAddress"],
            to: tx["to"],
            trace_id: tx["traceId"],
            value: tx["value"],
            is_error: tx["isError"] == "0" ? false : true,
            error_code: tx["errCode"],
            gas: tx["gas"],
            gas_used: tx["gasUsed"],
            gas_price: tx["gasPrice"],
            cumulative_gas_used: tx["cumulativeGasUsed"])
        rescue Exception => e
          # for some reason we can save but this returns an error
          puts e
        end
      else
        puts "EXISTS #{counter} \n\n#{tx}\n\n #{internal_tx.to_json}\n-----------"
      end
    end
  end
  def parse_transactions
    txs = get_transactions
    counter = 0
    txs.each do |tx|
      puts counter, tx
      counter+=1
      transaction = Transaction.where(hash: tx["hash"], to: tx["to"], from: tx["from"]).first
      if transaction.nil?
        # create 
        hsh = tx["hash"]
        bn = tx["blockNumber"]
        ts = tx["timeStamp"]
        begin
          transaction = Transaction.create(
            hash: hsh,
            block_number: bn,
            unixtimestamp: ts,
            from: tx["from"],
            contract_address: tx["contractAddress"],
            to: tx["to"],
            value: tx["value"],
            is_error: tx["isError"] == "0" ? false : true,
            gas: tx["gas"],
            gas_used: tx["gasUsed"],
            gas_price: tx["gasPrice"],
            receipt_status: tx["txreceipt_status"],
            cumulative_gas_used: tx["cumulativeGasUsed"])
        rescue Exception => e
          # for some reason we can save but this returns an error
          puts e
        end
      else
        puts "EXISTS #{counter} \n\n#{tx}\n\n #{transaction.to_json}\n-----------"
      end
    end
  end
end


# block_number:integer unixtimestamp:integer hash:string block_hash:string from:string contract_address:string to:string value:bigint token_name:string token_symbol:string token_decimal:integer gas:integer gas_used:integer gas_price:bigint cumulative_gas_used:bigint