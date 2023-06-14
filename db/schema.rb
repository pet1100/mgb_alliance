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

ActiveRecord::Schema[7.0].define(version: 2023_06_14_192126) do
  create_table "confirmations", force: :cascade do |t|
    t.string "code", limit: 128
    t.integer "confirmed_for_id"
    t.integer "confirmed_by_id"
    t.boolean "used", default: false
    t.index ["confirmed_by_id"], name: "index_confirmations_on_confirmed_by_id"
    t.index ["confirmed_for_id"], name: "index_confirmations_on_confirmed_for_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "last_used"
    t.string "uuid", limit: 64
    t.integer "rating", default: 0, null: false
  end

  add_foreign_key "confirmations", "users", column: "confirmed_by_id"
  add_foreign_key "confirmations", "users", column: "confirmed_for_id"
end
