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

ActiveRecord::Schema.define(version: 20150609033601) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "tablefunc"

  create_table "merchants", force: :cascade do |t|
    t.string "address"
    t.string "name"
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
  end

  create_table "products", force: :cascade do |t|
    t.decimal "price"
    t.string  "description"
    t.integer "merchant_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.integer "count"
    t.integer "person_id"
    t.integer "product_id"
  end

end
