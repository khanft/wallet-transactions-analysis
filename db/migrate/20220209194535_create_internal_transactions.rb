class CreateInternalTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :internal_transactions do |t|
      t.integer :block_number
      t.integer :unixtimestamp
      t.string :hash
      t.string :from
      t.string :contract_address
      t.string :to
      t.numeric :value
      t.string :type
      t.bigint :gas
      t.bigint :gas_used
      t.numeric :gas_price
      t.bigint :cumulative_gas_used
      t.boolean :is_error
      t.string :error_code
      t.string :trace_id

      t.timestamps
    end
  end
end
