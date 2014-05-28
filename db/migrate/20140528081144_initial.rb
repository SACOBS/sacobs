class Initial < ActiveRecord::Migration
   def self.up
    enable_extension "plpgsql"
    unless table_exists?(:addresses)
      create_table "addresses" do |t|
        t.string "street_address1"
        t.string "street_address2"
        t.string "city"
        t.string "postal_code"
        t.integer "addressable_id"
        t.string "addressable_type"
        t.datetime "created_at"
        t.datetime "updated_at"
      end

      add_index "addresses", ["addressable_id", "addressable_type"], name: "index_addresses_on_addressable_id_and_addressable_type", using: :btree
    end
    unless table_exists?(:banks)
      create_table "banks" do |t|
        t.string "name"
      end
    end
    unless table_exists?(:bookings)
          create_table "bookings" do |t|
            t.integer "trip_id"
            t.decimal "price"
            t.string "status"
            t.datetime "created_at"
            t.datetime "updated_at"
            t.integer "quantity", default: 0
            t.datetime "expiry_date"
            t.integer "client_id"
            t.integer "user_id"
            t.string "reference_no"
            t.integer "main_id"
            t.boolean "has_return", default: false
            t.integer "stop_id"
            t.integer "sequence_id"
          end

          add_index "bookings", ["client_id"], name: "index_bookings_on_client_id", using: :btree
          add_index "bookings", ["main_id"], name: "index_bookings_on_main_id", using: :btree
          add_index "bookings", ["stop_id"], name: "index_bookings_on_stop_id", using: :btree
          add_index "bookings", ["trip_id"], name: "index_bookings_on_trip_id", using: :btree
          add_index "bookings", ["user_id"], name: "index_bookings_on_user_id", using: :btree
        end
    unless table_exists?(:buses)
      create_table "buses" do |t|
        t.string "name"
        t.integer "capacity"
        t.string "year"
        t.string "model"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.integer "user_id"
      end

      add_index "buses", ["user_id"], name: "index_buses_on_user_id", using: :btree
    end
    unless table_exists?(:charges)
      create_table "charges" do |t|
        t.decimal "percentage", precision: 5, scale: 2
        t.integer "user_id"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.string "description"
      end

      add_index "charges", ["user_id"], name: "index_charges_on_user_id", using: :btree
    end
    unless table_exists?(:cities)
      create_table "cities" do |t|
        t.string "name"
        t.string "slug"
        t.integer "user_id"
        t.integer "venues_count", default: 0
        t.datetime "created_at"
        t.datetime "updated_at"
      end

      add_index "cities", ["slug"], name: "index_cities_on_slug", unique: true, using: :btree
      add_index "cities", ["user_id"], name: "index_cities_on_user_id", using: :btree
    end
    unless table_exists?(:clients)
      create_table "clients" do |t|
        t.string "name"
        t.string "surname"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.string "home_no"
        t.string "cell_no"
        t.string "email"
        t.string "slug"
        t.integer "user_id"
        t.string "full_name"
        t.boolean "high_risk", default: false
        t.integer "bank_id"
        t.string "work_no"
        t.date "date_of_birth"
        t.string "title"
        t.text "notes"
      end

      add_index "clients", ["bank_id"], name: "index_clients_on_bank_id", using: :btree
      add_index "clients", ["slug"], name: "index_clients_on_slug", unique: true, using: :btree
      add_index "clients", ["user_id"], name: "index_clients_on_user_id", using: :btree
    end
    unless table_exists?(:connections)
      create_table "connections" do |t|
        t.integer "distance"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.integer "route_id"
        t.decimal "percentage", precision: 5, scale: 2
        t.decimal "cost", precision: 8, scale: 2
        t.string "name"
        t.integer "from_id"
        t.integer "to_id"
        t.time "arrive"
        t.time "depart"
      end

      add_index "connections", ["from_id"], name: "index_connections_on_from_id", using: :btree
      add_index "connections", ["route_id"], name: "index_connections_on_route_id", using: :btree
      add_index "connections", ["to_id"], name: "index_connections_on_to_id", using: :btree
    end
    unless table_exists?(:destinations)
      create_table "destinations" do |t|
        t.integer "route_id"
        t.integer "city_id"
        t.integer "sequence"
        t.datetime "created_at"
        t.datetime "updated_at"
      end

      add_index "destinations", ["city_id", "route_id"], name: "index_destinations_on_city_id_and_route_id", using: :btree
      add_index "destinations", ["city_id"], name: "index_destinations_on_city_id", using: :btree
      add_index "destinations", ["route_id"], name: "index_destinations_on_route_id", using: :btree
    end
    unless table_exists?(:discounts)
      create_table "discounts" do |t|
        t.decimal "percentage", precision: 5, scale: 2
        t.integer "passenger_type_id"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.integer "user_id"
      end

      add_index "discounts", ["passenger_type_id"], name: "index_discounts_on_passenger_type_id", using: :btree
      add_index "discounts", ["user_id"], name: "index_discounts_on_user_id", using: :btree
    end
    unless table_exists?(:drivers)
      create_table "drivers" do |t|
        t.string "name"
        t.string "surname"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.string "slug"
        t.integer "user_id"
      end

      add_index "drivers", ["slug"], name: "index_drivers_on_slug", unique: true, using: :btree
      add_index "drivers", ["user_id"], name: "index_drivers_on_user_id", using: :btree
    end
    unless table_exists?(:drivers_trips)
      create_table "drivers_trips" do |t|
        t.integer "driver_id"
        t.integer "trip_id"
      end

      add_index "drivers_trips", ["driver_id", "trip_id"], name: "index_drivers_trips_on_driver_id_and_trip_id", using: :btree
      add_index "drivers_trips", ["trip_id", "driver_id"], name: "index_drivers_trips_on_trip_id_and_driver_id", using: :btree
    end
    unless table_exists?(:friendly_id_slugs)
      create_table "friendly_id_slugs" do |t|
        t.string "slug", null: false
        t.integer "sluggable_id", null: false
        t.string "sluggable_type", limit: 50
        t.string "scope"
        t.datetime "created_at"
      end

      add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
      add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
      add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
      add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
    end
    unless table_exists?(:invoices)
      create_table "invoices" do |t|
        t.integer "booking_id"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.datetime "billing_date"
      end

      add_index "invoices", ["booking_id"], name: "index_invoices_on_booking_id", using: :btree
    end
    unless table_exists?(:line_items)
      create_table "line_items" do |t|
        t.string "description"
        t.integer "invoice_id"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.decimal "amount", precision: 8, scale: 2
        t.string "line_item_type"
      end

      add_index "line_items", ["invoice_id"], name: "index_line_items_on_invoice_id", using: :btree
    end
    unless table_exists?(:passenger_types)
      create_table "passenger_types" do |t|
        t.string "description"
        t.datetime "created_at"
        t.datetime "updated_at"
      end
    end
    unless table_exists?(:passengers)
      create_table "passengers" do |t|
        t.string "name"
        t.string "surname"
        t.integer "booking_id"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.integer "passenger_type_id"
        t.string "cell_no"
        t.string "email"
      end

      add_index "passengers", ["booking_id"], name: "index_passengers_on_booking_id", using: :btree
      add_index "passengers", ["passenger_type_id"], name: "index_passengers_on_passenger_type_id", using: :btree
    end
    unless table_exists?(:payment_details)
      create_table "payment_details" do |t|
        t.datetime "payment_date"
        t.integer "booking_id"
        t.string "reference"
        t.integer "user_id"
        t.integer "payment_type_id"
      end

      add_index "payment_details", ["booking_id"], name: "index_payment_details_on_booking_id", using: :btree
      add_index "payment_details", ["payment_type_id"], name: "index_payment_details_on_payment_type_id", using: :btree
      add_index "payment_details", ["user_id"], name: "index_payment_details_on_user_id", using: :btree
    end
    unless table_exists?(:payment_types)
      create_table "payment_types" do |t|
        t.string "description"
        t.datetime "created_at"
        t.datetime "updated_at"
      end
    end
    unless table_exists?(:routes)
      create_table "routes" do |t|
        t.decimal "cost", precision: 8, scale: 2
        t.integer "distance"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.string "name"
        t.string "slug"
        t.integer "user_id"
        t.integer "connections_count", default: 0
      end

      add_index "routes", ["slug"], name: "index_routes_on_slug", unique: true, using: :btree
      add_index "routes", ["user_id"], name: "index_routes_on_user_id", using: :btree
    end
    unless table_exists?(:scriptures)
      create_table "scriptures" do |t|
        t.string "verse"
        t.datetime "created_at"
        t.datetime "updated_at"
      end
    end
    unless table_exists?(:seasonal_markups)
      create_table "seasonal_markups" do |t|
        t.decimal "percentage"
        t.date "period_from"
        t.date "period_to"
        t.boolean "active", default: false
        t.datetime "created_at"
        t.datetime "updated_at"
        t.integer "user_id"
      end

      add_index "seasonal_markups", ["user_id"], name: "index_seasonal_markups_on_user_id", using: :btree
    end
    unless table_exists?(:seats)
      create_table "seats" do |t|
        t.string "row"
        t.integer "number"
        t.integer "bus_id"
        t.datetime "created_at"
        t.datetime "updated_at"
      end

      add_index "seats", ["bus_id"], name: "index_seats_on_bus_id", using: :btree
    end
    unless table_exists?(:settings)
      create_table "settings" do |t|
        t.integer "booking_expiry_period"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.string "ticket_instructions"
        t.string "default_scripture"
        t.string "trip_sheet_note1"
        t.string "trip_sheet_note2"
        t.string "trip_sheet_note3"
        t.string "trip_sheet_note4"
      end
    end
    unless table_exists?(:stops)
      create_table "stops" do |t|
        t.integer "connection_id"
        t.integer "trip_id"
        t.time "arrive"
        t.time "depart"
        t.integer "available_seats"
        t.datetime "created_at"
        t.datetime "updated_at"
      end

      add_index "stops", ["connection_id"], name: "index_stops_on_connection_id", using: :btree
      add_index "stops", ["trip_id"], name: "index_stops_on_trip_id", using: :btree
    end
    unless table_exists?(:trips)
      create_table "trips" do |t|
        t.string "name"
        t.date "start_date"
        t.date "end_date"
        t.integer "route_id"
        t.integer "bus_id"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.integer "user_id"
        t.text "notes"
      end

      add_index "trips", ["bus_id"], name: "index_trips_on_bus_id", using: :btree
      add_index "trips", ["route_id"], name: "index_trips_on_route_id", using: :btree
      add_index "trips", ["user_id"], name: "index_trips_on_user_id", using: :btree
    end
    unless table_exists?(:users)
      create_table "users" do |t|
        t.string "email", default: "", null: false
        t.string "encrypted_password", default: "", null: false
        t.string "reset_password_token"
        t.datetime "reset_password_sent_at"
        t.datetime "remember_created_at"
        t.integer "sign_in_count", default: 0, null: false
        t.datetime "current_sign_in_at"
        t.datetime "last_sign_in_at"
        t.string "current_sign_in_ip"
        t.string "last_sign_in_ip"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.string "name"
        t.string "surname"
        t.string "role"
      end

      add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
      add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    end
    unless table_exists?(:venues)
      create_table "venues" do |t|
        t.string "name"
        t.integer "city_id"
        t.datetime "created_at"
        t.datetime "updated_at"
      end

      add_index "venues", ["city_id"], name: "index_venues_on_city_id", using: :btree
    end
    unless table_exists?(:vouchers)
      create_table "vouchers" do |t|
        t.string "ref_no"
        t.decimal "amount"
        t.boolean "active", default: true
        t.integer "client_id"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.integer "user_id"
      end

      add_index "vouchers", ["client_id"], name: "index_vouchers_on_client_id", using: :btree
      add_index "vouchers", ["user_id"], name: "index_vouchers_on_user_id", using: :btree
    end

  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end

