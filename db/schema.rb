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

ActiveRecord::Schema.define(version: 20131111180156) do

  create_table "addresses", force: true do |t|
    t.string   "street_address1"
    t.string   "street_address2"
    t.string   "city"
    t.string   "postal_code"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bookings", force: true do |t|
    t.integer  "trip_id"
    t.decimal  "price"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity",    default: 0
    t.datetime "expiry_date"
    t.integer  "client_id"
    t.integer  "user_id"
  end

  create_table "bookings_stops", force: true do |t|
    t.integer "booking_id"
    t.integer "stop_id"
  end

  create_table "buses", force: true do |t|
    t.string   "name"
    t.integer  "capacity"
    t.string   "year"
    t.string   "model"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "cities", force: true do |t|
    t.string  "name"
    t.string  "slug"
    t.integer "user_id"
  end

  add_index "cities", ["slug"], name: "index_cities_on_slug", unique: true

  create_table "clients", force: true do |t|
    t.string   "name"
    t.string   "surname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tel_no"
    t.string   "cell_no"
    t.string   "email"
    t.string   "slug"
    t.integer  "user_id"
  end

  add_index "clients", ["slug"], name: "index_clients_on_slug", unique: true

  create_table "connections", force: true do |t|
    t.integer  "from_city_id"
    t.integer  "to_city_id"
    t.integer  "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "route_id"
    t.integer  "percentage",   limit: 2
    t.decimal  "cost",                   precision: 8, scale: 2
    t.string   "name"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "discounts", force: true do |t|
    t.integer  "percentage"
    t.integer  "passenger_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drivers", force: true do |t|
    t.string   "name"
    t.string   "surname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "user_id"
  end

  add_index "drivers", ["slug"], name: "index_drivers_on_slug", unique: true

  create_table "drivers_trips", force: true do |t|
    t.integer "driver_id"
    t.integer "trip_id"
  end

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "invoices", force: true do |t|
    t.integer  "booking_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "billing_date"
  end

  create_table "line_items", force: true do |t|
    t.string   "description"
    t.integer  "discount_percentage"
    t.decimal  "discount_amount",     precision: 8, scale: 2
    t.integer  "invoice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "gross_price",         precision: 8, scale: 2
    t.decimal  "nett_price",          precision: 8, scale: 2
  end

  create_table "passenger_types", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "passengers", force: true do |t|
    t.string   "name"
    t.string   "surname"
    t.integer  "booking_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "passenger_type_id"
    t.string   "cell_no"
    t.string   "email"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "routes", force: true do |t|
    t.integer  "start_city_id"
    t.integer  "end_city_id"
    t.decimal  "cost",          precision: 8, scale: 2
    t.integer  "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "slug"
    t.integer  "user_id"
  end

  add_index "routes", ["slug"], name: "index_routes_on_slug", unique: true

  create_table "seats", force: true do |t|
    t.string   "row"
    t.integer  "number"
    t.integer  "bus_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "seats", ["bus_id"], name: "index_seats_on_bus_id"

  create_table "stops", force: true do |t|
    t.integer  "connection_id"
    t.integer  "trip_id"
    t.datetime "arrive"
    t.datetime "depart"
    t.integer  "available_seats"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trips", force: true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "route_id"
    t.integer  "bus_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "users", force: true do |t|
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
    t.string   "name"
    t.string   "surname"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

  create_table "venues", force: true do |t|
    t.string   "name"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
