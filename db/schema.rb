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

ActiveRecord::Schema.define(version: 2019_07_25_013926) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "announcements", force: :cascade do |t|
    t.integer "user_id"
    t.string "text"
    t.integer "placement_id"
    t.integer "licensee_id"
    t.boolean "bed_available", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cart_placements", force: :cascade do |t|
    t.bigint "cart_id"
    t.bigint "placement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_cart_placements_on_cart_id"
    t.index ["placement_id"], name: "index_cart_placements_on_placement_id"
  end

  create_table "carts", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "placement_id"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "counties", force: :cascade do |t|
    t.string "name"
    t.string "mco"
    t.string "hospital"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "licensees", force: :cascade do |t|
    t.string "facility_name"
    t.string "contact_name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone"
    t.string "fax"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "placements", force: :cascade do |t|
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone"
    t.integer "licensee_id"
    t.integer "service_id"
    t.string "gender"
    t.integer "beds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.string "full_address"
    t.integer "county_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.string "prog_code"
    t.string "age_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cart_placements", "carts"
  add_foreign_key "cart_placements", "placements"
  add_foreign_key "carts", "users"
end
