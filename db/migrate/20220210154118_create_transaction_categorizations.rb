class CreateTransactionCategorizations < ActiveRecord::Migration[6.1]
  def change
    create_table :transaction_categorizations do |t|
      t.references :transaction, foreign_key: true
      t.references :internal_transaction, foreign_key: true
      t.references :nft_transaction, foreign_key: true
      t.references :erc20_transaction, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
