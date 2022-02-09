class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :block_number
      t.integer :unixtimestamp
      t.string :hash
      t.string :from
      t.string :contract_address
      t.string :to
      t.numeric :value
      t.bigint :gas
      t.bigint :gas_used
      t.numeric :gas_price
      t.bigint :cumulative_gas_used
      t.boolean :is_error
      t.string :receipt_status

      t.timestamps
    end
  end
end
