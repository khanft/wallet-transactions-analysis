# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_02_09_223559) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "erc20_transactions", force: :cascade do |t|
    t.integer "block_number"
    t.bigint "unixtimestamp"
    t.string "hash"
    t.string "block_hash"
    t.string "from"
    t.string "contract_address"
    t.string "to"
    t.decimal "value"
    t.string "token_name"
    t.string "token_symbol"
    t.bigint "token_decimal"
    t.bigint "gas"
    t.bigint "gas_used"
    t.decimal "gas_price"
    t.bigint "cumulative_gas_used"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "internal_transactions", force: :cascade do |t|
    t.integer "block_number"
    t.integer "unixtimestamp"
    t.string "hash"
    t.string "from"
    t.string "contract_address"
    t.string "to"
    t.decimal "value"
    t.string "type"
    t.bigint "gas"
    t.bigint "gas_used"
    t.decimal "gas_price"
    t.bigint "cumulative_gas_used"
    t.boolean "is_error"
    t.string "error_code"
    t.string "trace_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "nft_transactions", force: :cascade do |t|
    t.integer "block_number"
    t.integer "unixtimestamp"
    t.string "hash"
    t.string "block_hash"
    t.string "from"
    t.string "contract_address"
    t.string "to"
    t.decimal "token_id"
    t.string "token_name"
    t.string "token_symbol"
    t.bigint "token_decimal"
    t.bigint "gas"
    t.bigint "gas_used"
    t.bigint "gas_price"
    t.bigint "cumulative_gas_used"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "scrapable_addresses", force: :cascade do |t|
    t.string "address"
    t.string "name"
    t.boolean "is_hot_wallet"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "block_number"
    t.integer "unixtimestamp"
    t.string "hash"
    t.string "from"
    t.string "contract_address"
    t.string "to"
    t.decimal "value"
    t.bigint "gas"
    t.bigint "gas_used"
    t.decimal "gas_price"
    t.bigint "cumulative_gas_used"
    t.boolean "is_error"
    t.string "receipt_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
