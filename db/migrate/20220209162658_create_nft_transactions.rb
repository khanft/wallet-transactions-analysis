class CreateNftTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :nft_transactions do |t|
      t.integer :block_number
      t.integer :unixtimestamp
      t.string :hash
      t.string :block_hash
      t.string :from
      t.string :contract_address
      t.string :to
      t.numeric :token_id
      t.string :token_name
      t.string :token_symbol
      t.bigint :token_decimal
      t.bigint :gas
      t.bigint :gas_used
      t.bigint :gas_price
      t.bigint :cumulative_gas_used

      t.timestamps
    end
  end
end
