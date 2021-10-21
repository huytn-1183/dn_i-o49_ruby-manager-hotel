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

ActiveRecord::Schema.define(version: 2021_10_21_021546) do

  create_table "booking_details", force: :cascade do |t|
    t.date "date_in"
    t.date "date_out"
    t.integer "days_range"
    t.integer "room_id", null: false
    t.integer "booking_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["booking_id"], name: "index_booking_details_on_booking_id"
    t.index ["room_id"], name: "index_booking_details_on_room_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.string "payment_type"
    t.date "payment_date"
    t.integer "status", default: 0, null: false
    t.integer "user_id", null: false
    t.integer "contact_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contact_id"], name: "index_bookings_on_contact_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "phone"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "room_attributes", force: :cascade do |t|
    t.string "name"
    t.integer "room_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_id"], name: "index_room_attributes_on_room_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "image"
    t.integer "price"
    t.integer "type", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "gender"
    t.string "code"
    t.string "email"
    t.string "phone"
    t.string "address"
    t.string "image"
    t.string "password_digest"
    t.integer "role", default: 0, null: false
    t.integer "contact_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contact_id"], name: "index_users_on_contact_id"
  end

  add_foreign_key "booking_details", "bookings"
  add_foreign_key "booking_details", "rooms"
  add_foreign_key "bookings", "contacts"
  add_foreign_key "bookings", "users"
  add_foreign_key "room_attributes", "rooms"
  add_foreign_key "users", "contacts"
end