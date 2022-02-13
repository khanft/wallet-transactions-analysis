class CreateScrapableAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :scrapable_addresses do |t|
      t.string :address
      t.string :name
      t.boolean :is_hot_wallet

      t.timestamps
    end
  end
end
