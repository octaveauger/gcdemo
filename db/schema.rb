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

ActiveRecord::Schema.define(version: 20150305233218) do

  create_table "admins", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "merchants", force: true do |t|
    t.integer  "admin_id"
    t.string   "name"
    t.string   "mandate_name"
    t.string   "address1"
    t.string   "postcode"
    t.string   "city"
    t.string   "api_id"
    t.string   "api_key"
    t.string   "logo"
    t.string   "product_image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "merchants", ["admin_id"], name: "index_merchants_on_admin_id"
  add_index "merchants", ["name"], name: "index_merchants_on_name"

  create_table "payment_templates", force: true do |t|
    t.integer  "merchant_id"
    t.float    "amount_gbp"
    t.float    "amount_eur"
    t.integer  "charge_date"
    t.string   "reference"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nickname"
  end

  add_index "payment_templates", ["merchant_id"], name: "index_payment_templates_on_merchant_id"

  create_table "subscription_templates", force: true do |t|
    t.integer  "merchant_id"
    t.string   "name"
    t.float    "amount_gbp"
    t.float    "amount_eur"
    t.integer  "day_of_month"
    t.string   "interval_unit"
    t.integer  "interval"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscription_templates", ["merchant_id"], name: "index_subscription_templates_on_merchant_id"

end
