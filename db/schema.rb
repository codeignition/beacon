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

ActiveRecord::Schema.define(version: 20150811100910) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "call_logs", force: true do |t|
    t.string   "phone_number"
    t.string   "escalation_rule_key"
    t.integer  "level_number"
    t.integer  "complaint_id"
    t.datetime "answered_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "complaints", force: true do |t|
    t.string   "status"
    t.integer  "escalation_rule_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ip_address"
    t.integer  "organization_id"
  end

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.string   "phone_number"
    t.string   "email_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "organization_id"
    t.datetime "confirmed_at"
  end

  create_table "escalation_rules", force: true do |t|
    t.string   "name"
    t.string   "rule_key"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
    t.boolean  "airplane_mode_on"
    t.integer  "airplane_mode_start_time"
    t.integer  "airplane_mode_end_time"
    t.string   "voice_message",            default: "server down"
  end

  create_table "levels", force: true do |t|
    t.integer  "escalation_rule_id"
    t.integer  "contact_id"
    t.integer  "level_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organization_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.boolean  "is_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.boolean  "tour_taken",             default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
