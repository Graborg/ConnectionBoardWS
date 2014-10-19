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

ActiveRecord::Schema.define(version: 20141018142819) do

  create_table "accounts", force: true do |t|
    t.string   "password_digest",        null: false
    t.string   "username",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  add_index "accounts", ["username"], name: "index_accounts_on_username", unique: true

  create_table "api_tokens", force: true do |t|
    t.string   "access_token", null: false
    t.integer  "account_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "api_tokens", ["account_id"], name: "index_api_tokens_on_account_id", unique: true

  create_table "mail_logs", force: true do |t|
    t.integer  "from_id"
    t.integer  "to_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.string   "name"
    t.text     "expectations"
    t.text     "skills"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id",   null: false
    t.integer  "show_profile", null: false
    t.integer  "image",        null: false
  end

  add_index "people", ["account_id"], name: "index_people_on_account_id", unique: true

  create_table "projects", force: true do |t|
    t.string   "title"
    t.string   "subheading"
    t.text     "requested_skills"
    t.text     "gains"
    t.text     "description"
    t.string   "time_plan"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id",       null: false
    t.integer  "show_project",     null: false
    t.integer  "image",            null: false
  end

end
