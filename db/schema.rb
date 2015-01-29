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

ActiveRecord::Schema.define(version: 20150129125409) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "street_address1",  limit: 255
    t.string   "street_address2",  limit: 255
    t.string   "city",             limit: 255
    t.string   "postal_code",      limit: 255
    t.integer  "addressable_id"
    t.string   "addressable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["addressable_id", "addressable_type"], name: "index_addresses_on_addressable_id_and_addressable_type", using: :btree

  create_table "banks", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "bookings", force: :cascade do |t|
    t.integer  "trip_id"
    t.decimal  "price"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity"
    t.datetime "expiry_date"
    t.integer  "client_id"
    t.integer  "user_id"
    t.string   "reference_no", limit: 255
    t.integer  "main_id"
    t.boolean  "has_return"
    t.integer  "stop_id"
    t.integer  "sequence_id",              default: "nextval('sequence_id_seq'::regclass)"
  end

  add_index "bookings", ["client_id"], name: "index_bookings_on_client_id", using: :btree
  add_index "bookings", ["main_id"], name: "index_bookings_on_main_id", using: :btree
  add_index "bookings", ["stop_id"], name: "index_bookings_on_stop_id", using: :btree
  add_index "bookings", ["trip_id"], name: "index_bookings_on_trip_id", using: :btree
  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id", using: :btree

  create_table "buses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "capacity"
    t.string   "year",       limit: 255
    t.string   "model",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "buses", ["user_id"], name: "index_buses_on_user_id", using: :btree

  create_table "charges", force: :cascade do |t|
    t.decimal  "percentage",              precision: 5, scale: 2
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description", limit: 255
  end

  add_index "charges", ["user_id"], name: "index_charges_on_user_id", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.integer  "user_id"
    t.integer  "venues_count",             default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["user_id"], name: "index_cities_on_user_id", using: :btree

  create_table "clients", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "surname",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "home_no",       limit: 255
    t.string   "cell_no",       limit: 255
    t.string   "email",         limit: 255
    t.integer  "user_id"
    t.boolean  "high_risk",                 default: false
    t.string   "work_no",       limit: 255
    t.date     "date_of_birth"
    t.string   "title",         limit: 255
    t.text     "notes"
    t.string   "id_number",     limit: 255
    t.string   "bank",          limit: 255
  end

  add_index "clients", ["name", "surname"], name: "index_clients_on_name_and_surname", unique: true, using: :btree
  add_index "clients", ["user_id"], name: "index_clients_on_user_id", using: :btree

  create_table "connections", force: :cascade do |t|
    t.integer  "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "route_id"
    t.decimal  "percentage",             precision: 5, scale: 2
    t.decimal  "cost",                   precision: 8, scale: 2
    t.string   "name",       limit: 255
    t.integer  "from_id"
    t.integer  "to_id"
    t.time     "arrive"
    t.time     "depart"
  end

  add_index "connections", ["from_id"], name: "index_connections_on_from_id", using: :btree
  add_index "connections", ["route_id"], name: "index_connections_on_route_id", using: :btree
  add_index "connections", ["to_id"], name: "index_connections_on_to_id", using: :btree

  create_table "destinations", force: :cascade do |t|
    t.integer  "route_id"
    t.integer  "city_id"
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "destinations", ["city_id", "route_id"], name: "index_destinations_on_city_id_and_route_id", using: :btree
  add_index "destinations", ["city_id"], name: "index_destinations_on_city_id", using: :btree
  add_index "destinations", ["route_id"], name: "index_destinations_on_route_id", using: :btree

  create_table "discounts", force: :cascade do |t|
    t.decimal  "percentage",        precision: 5, scale: 2
    t.integer  "passenger_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "discounts", ["passenger_type_id"], name: "index_discounts_on_passenger_type_id", using: :btree
  add_index "discounts", ["user_id"], name: "index_discounts_on_user_id", using: :btree

  create_table "drivers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "surname",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "drivers", ["user_id"], name: "index_drivers_on_user_id", using: :btree

  create_table "drivers_trips", force: :cascade do |t|
    t.integer "driver_id"
    t.integer "trip_id"
  end

  add_index "drivers_trips", ["driver_id", "trip_id"], name: "index_drivers_trips_on_driver_id_and_trip_id", using: :btree
  add_index "drivers_trips", ["trip_id", "driver_id"], name: "index_drivers_trips_on_trip_id_and_driver_id", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.integer  "booking_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "billing_date"
  end

  add_index "invoices", ["booking_id"], name: "index_invoices_on_booking_id", using: :btree

  create_table "line_items", force: :cascade do |t|
    t.string   "description",    limit: 255
    t.integer  "invoice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "amount",                     precision: 8, scale: 2
    t.integer  "line_item_type"
  end

  add_index "line_items", ["invoice_id"], name: "index_line_items_on_invoice_id", using: :btree

  create_table "notes", force: :cascade do |t|
    t.text    "content"
    t.string  "context", limit: 255
    t.integer "user_id"
  end

  add_index "notes", ["user_id"], name: "index_notes_on_user_id", using: :btree

  create_table "passenger_types", force: :cascade do |t|
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "passengers", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "surname",           limit: 255
    t.integer  "booking_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "passenger_type_id"
    t.string   "cell_no",           limit: 255
    t.string   "email",             limit: 255
    t.integer  "charges",                       default: [], array: true
  end

  add_index "passengers", ["booking_id"], name: "index_passengers_on_booking_id", using: :btree
  add_index "passengers", ["passenger_type_id"], name: "index_passengers_on_passenger_type_id", using: :btree

  create_table "payment_details", force: :cascade do |t|
    t.datetime "payment_date"
    t.integer  "booking_id"
    t.string   "reference",    limit: 255
    t.integer  "user_id"
    t.string   "payment_type", limit: 255
  end

  add_index "payment_details", ["booking_id"], name: "index_payment_details_on_booking_id", using: :btree
  add_index "payment_details", ["user_id"], name: "index_payment_details_on_user_id", using: :btree

  create_table "reports", force: :cascade do |t|
    t.string   "name",                    null: false
    t.hstore   "criteria",   default: {}, null: false
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "routes", force: :cascade do |t|
    t.decimal  "cost",                   precision: 8, scale: 2
    t.integer  "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",       limit: 255
    t.integer  "user_id"
  end

  add_index "routes", ["user_id"], name: "index_routes_on_user_id", using: :btree

  create_table "scriptures", force: :cascade do |t|
    t.string   "verse",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seasonal_discounts", force: :cascade do |t|
    t.decimal  "percentage"
    t.date     "period_from"
    t.date     "period_to"
    t.boolean  "active",                        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "passenger_type_id"
    t.string   "name",              limit: 255
  end

  add_index "seasonal_discounts", ["passenger_type_id"], name: "index_seasonal_discounts_on_passenger_type_id", using: :btree
  add_index "seasonal_discounts", ["user_id"], name: "index_seasonal_discounts_on_user_id", using: :btree

  create_table "seats", force: :cascade do |t|
    t.string   "row",        limit: 255
    t.integer  "number"
    t.integer  "bus_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "seats", ["bus_id"], name: "index_seats_on_bus_id", using: :btree

  create_table "settings", force: :cascade do |t|
    t.integer  "booking_expiry_period"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ticket_instructions",   limit: 255
    t.string   "default_scripture",     limit: 255
    t.string   "trip_sheet_note1",      limit: 255
    t.string   "trip_sheet_note2",      limit: 255
    t.string   "trip_sheet_note3",      limit: 255
    t.string   "trip_sheet_note4",      limit: 255
  end

  create_table "stops", force: :cascade do |t|
    t.integer  "connection_id"
    t.integer  "trip_id"
    t.time     "arrive"
    t.time     "depart"
    t.integer  "available_seats"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stops", ["connection_id"], name: "index_stops_on_connection_id", using: :btree
  add_index "stops", ["trip_id"], name: "index_stops_on_trip_id", using: :btree

  create_table "temp_data", force: :cascade do |t|
    t.string "session_id", limit: 255
    t.hstore "data"
  end

  create_table "trips", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "route_id"
    t.integer  "bus_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.text     "notes"
  end

  add_index "trips", ["bus_id"], name: "index_trips_on_bus_id", using: :btree
  add_index "trips", ["route_id"], name: "index_trips_on_route_id", using: :btree
  add_index "trips", ["user_id"], name: "index_trips_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.string   "surname",                limit: 255
    t.integer  "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venues", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venues", ["city_id"], name: "index_venues_on_city_id", using: :btree

  create_table "vouchers", force: :cascade do |t|
    t.string   "ref_no",     limit: 255
    t.decimal  "amount"
    t.boolean  "active",                 default: true
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "vouchers", ["client_id"], name: "index_vouchers_on_client_id", using: :btree
  add_index "vouchers", ["user_id"], name: "index_vouchers_on_user_id", using: :btree

  add_foreign_key "bookings", "clients", on_delete: :cascade
end
