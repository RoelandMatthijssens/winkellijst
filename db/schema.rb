# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160325135214) do

  create_table "households", force: :cascade do |t|
    t.string   "name"
    t.integer  "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "households_users", id: false, force: :cascade do |t|
    t.integer "household_id", null: false
    t.integer "user_id",      null: false
  end

  add_index "households_users", ["household_id", "user_id"], name: "index_households_users_on_household_id_and_user_id"
  add_index "households_users", ["user_id", "household_id"], name: "index_households_users_on_user_id_and_household_id"

  create_table "invites", force: :cascade do |t|
    t.integer  "household_id"
    t.integer  "inviter_id"
    t.integer  "invitee_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items_stores", id: false, force: :cascade do |t|
    t.integer "item_id",  null: false
    t.integer "store_id", null: false
  end

  add_index "items_stores", ["item_id", "store_id"], name: "index_items_stores_on_item_id_and_store_id"
  add_index "items_stores", ["store_id", "item_id"], name: "index_items_stores_on_store_id_and_item_id"

  create_table "shopping_list_items", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "shopping_list_id"
    t.integer  "added_by_id"
    t.integer  "amount"
    t.boolean  "bought",           default: false, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "shopping_lists", force: :cascade do |t|
    t.integer  "creator_id"
    t.integer  "household_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
