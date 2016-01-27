class Initial < ActiveRecord::Migration
  def self.up
    # These are extensions that must be enabled in order to support this database
    enable_extension 'plpgsql'
    enable_extension 'hstore'

    create_table 'banks', force: :cascade do |t|
      t.string 'name', limit: 255
    end

    create_table 'bookings', force: :cascade do |t|
      t.integer  'trip_id'
      t.decimal  'price',                         default: 0.0
      t.integer  'status',                        default: 0
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.integer  'quantity', default: 0
      t.datetime 'expiry_date'
      t.integer  'client_id'
      t.integer  'user_id'
      t.string   'reference_no', limit: 255
      t.integer  'main_id'
      t.integer  'stop_id'
      t.integer  'sequence_id',                   default: "nextval('sequence_id_seq'::regclass)"
      t.boolean  'archived',                      default: false
      t.datetime 'archived_at'
      t.integer  'payment_detail_id'
    end

    add_index 'bookings', ['archived'], name: 'index_bookings_on_archived', where: '(archived = false)', using: :btree
    add_index 'bookings', ['client_id'], name: 'index_bookings_on_client_id', using: :btree
    add_index 'bookings', ['main_id'], name: 'index_bookings_on_main_id', using: :btree
    add_index 'bookings', ['stop_id'], name: 'index_bookings_on_stop_id', using: :btree
    add_index 'bookings', ['trip_id'], name: 'index_bookings_on_trip_id', using: :btree

    create_table 'buses', force: :cascade do |t|
      t.string   'name',       limit: 255
      t.integer  'capacity', default: 0
      t.string   'year',       limit: 255
      t.string   'model',      limit: 255
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.integer  'user_id'
    end

    create_table 'charges', force: :cascade do |t|
      t.decimal  'percentage',              precision: 5, scale: 2
      t.integer  'user_id'
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.string   'description', limit: 255
    end

    create_table 'cities', force: :cascade do |t|
      t.string   'name', limit: 255
      t.integer  'user_id'
      t.integer  'venues_count', default: 0
      t.datetime 'created_at'
      t.datetime 'updated_at'
    end

    add_index 'cities', ['name'], name: 'index_cities_on_name', using: :btree

    create_table 'clients', force: :cascade do |t|
      t.string   'name',            limit: 255
      t.string   'surname',         limit: 255
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.string   'home_no',         limit: 255
      t.string   'cell_no',         limit: 255
      t.string   'email',           limit: 255
      t.integer  'user_id'
      t.boolean  'high_risk', default: false
      t.string   'work_no', limit: 255
      t.date     'date_of_birth'
      t.string   'title', limit: 255
      t.text     'notes'
      t.string   'id_number',       limit: 255
      t.string   'bank',            limit: 255
      t.string   'street_address1'
      t.string   'street_address2'
      t.string   'city'
      t.string   'postal_code'
    end

    add_index 'clients', %w(name surname), name: 'index_clients_on_name_and_surname', unique: true, using: :btree

    create_table 'connections', force: :cascade do |t|
      t.integer  'distance', default: 0
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.integer  'route_id'
      t.decimal  'percentage',             precision: 5, scale: 2, default: 0.0
      t.decimal  'cost',                   precision: 8, scale: 2, default: 0.0
      t.string   'name', limit: 255
      t.integer  'from_id'
      t.integer  'to_id'
      t.time     'leaving',                                        default: '2000-01-01 05:47:45'
      t.time     'arriving',                                       default: '2000-01-01 05:47:45'
    end

    add_index 'connections', ['from_id'], name: 'index_connections_on_from_id', using: :btree
    add_index 'connections', ['route_id'], name: 'index_connections_on_route_id', using: :btree
    add_index 'connections', ['to_id'], name: 'index_connections_on_to_id', using: :btree

    create_table 'destinations', force: :cascade do |t|
      t.integer  'route_id'
      t.integer  'city_id'
      t.integer  'sequence'
      t.datetime 'created_at'
      t.datetime 'updated_at'
    end

    add_index 'destinations', %w(city_id route_id), name: 'index_destinations_on_city_id_and_route_id', using: :btree
    add_index 'destinations', ['city_id'], name: 'index_destinations_on_city_id', using: :btree
    add_index 'destinations', ['route_id'], name: 'index_destinations_on_route_id', using: :btree
    add_index 'destinations', ['sequence'], name: 'index_destinations_on_sequence', using: :btree

    create_table 'discounts', force: :cascade do |t|
      t.decimal  'percentage', precision: 5, scale: 2
      t.integer  'passenger_type_id'
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.integer  'user_id'
    end

    add_index 'discounts', ['passenger_type_id'], name: 'index_discounts_on_passenger_type_id', using: :btree

    create_table 'drivers', force: :cascade do |t|
      t.string   'name',       limit: 255
      t.string   'surname',    limit: 255
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.integer  'user_id'
    end

    create_table 'drivers_trips', force: :cascade do |t|
      t.integer 'driver_id'
      t.integer 'trip_id'
    end

    add_index 'drivers_trips', %w(driver_id trip_id), name: 'index_drivers_trips_on_driver_id_and_trip_id', using: :btree
    add_index 'drivers_trips', %w(trip_id driver_id), name: 'index_drivers_trips_on_trip_id_and_driver_id', using: :btree

    create_table 'invoices', force: :cascade do |t|
      t.integer  'booking_id'
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.datetime 'billing_date'
    end

    add_index 'invoices', ['booking_id'], name: 'index_invoices_on_booking_id', using: :btree

    create_table 'line_items', force: :cascade do |t|
      t.string   'description', limit: 255
      t.integer  'invoice_id'
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.decimal  'amount', precision: 8, scale: 2, default: 0.0
      t.integer  'line_item_type'
    end

    add_index 'line_items', ['invoice_id'], name: 'index_line_items_on_invoice_id', using: :btree

    create_table 'notes', force: :cascade do |t|
      t.text    'content'
      t.string  'context', limit: 255
      t.integer 'user_id'
    end

    create_table 'passenger_types', force: :cascade do |t|
      t.string   'description', limit: 255
      t.datetime 'created_at'
      t.datetime 'updated_at'
    end

    create_table 'passengers', force: :cascade do |t|
      t.string   'name',              limit: 255
      t.string   'surname',           limit: 255
      t.integer  'booking_id'
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.integer  'passenger_type_id'
      t.string   'cell_no',           limit: 255
      t.string   'email',             limit: 255
      t.integer  'charges', default: [], array: true
    end

    add_index 'passengers', ['booking_id'], name: 'index_passengers_on_booking_id', using: :btree
    add_index 'passengers', ['passenger_type_id'], name: 'index_passengers_on_passenger_type_id', using: :btree

    create_table 'payment_details', force: :cascade do |t|
      t.datetime 'paid_at'
      t.string   'reference', limit: 255
      t.integer  'user_id'
      t.string   'payment_type', limit: 255
    end

    create_table 'reports', force: :cascade do |t|
      t.string   'name', null: false
      t.integer  'user_id'
      t.datetime 'created_at',                  null: false
      t.datetime 'updated_at',                  null: false
      t.json     'criteria', default: {}, null: false
      t.date     'period_from'
      t.date     'period_to'
      t.boolean  'daily', default: false
    end

    create_table 'routes', force: :cascade do |t|
      t.decimal  'cost', precision: 8, scale: 2
      t.integer  'distance'
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.string   'name', limit: 255
      t.integer  'user_id'
      t.integer  'connections_count', default: 0
    end

    create_table 'scriptures', force: :cascade do |t|
      t.string   'verse',      limit: 255
      t.datetime 'created_at'
      t.datetime 'updated_at'
    end

    create_table 'seasonal_discounts', force: :cascade do |t|
      t.decimal  'percentage'
      t.date     'period_from'
      t.date     'period_to'
      t.boolean  'active', default: true
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.integer  'user_id'
      t.integer  'passenger_type_id'
      t.string   'name', limit: 255
    end

    add_index 'seasonal_discounts', ['passenger_type_id'], name: 'index_seasonal_discounts_on_passenger_type_id', using: :btree
    add_index 'seasonal_discounts', ['user_id'], name: 'index_seasonal_discounts_on_user_id', using: :btree

    create_table 'seats', force: :cascade do |t|
      t.string   'row', limit: 255, default: 'A-Z'
      t.integer  'number', default: 0
      t.integer  'bus_id'
      t.datetime 'created_at'
      t.datetime 'updated_at'
    end

    add_index 'seats', ['bus_id'], name: 'index_seats_on_bus_id', using: :btree

    create_table 'settings', force: :cascade do |t|
      t.integer  'booking_expiry_period'
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.string   'ticket_instructions',   limit: 255
      t.string   'default_scripture',     limit: 255
      t.string   'trip_sheet_note1',      limit: 255
      t.string   'trip_sheet_note2',      limit: 255
      t.string   'trip_sheet_note3',      limit: 255
      t.string   'trip_sheet_note4',      limit: 255
      t.string   'email'
    end

    create_table 'stops', force: :cascade do |t|
      t.integer  'connection_id'
      t.integer  'trip_id'
      t.integer  'available_seats'
      t.datetime 'created_at'
      t.datetime 'updated_at'
    end

    add_index 'stops', ['connection_id'], name: 'index_stops_on_connection_id', using: :btree
    add_index 'stops', ['trip_id'], name: 'index_stops_on_trip_id', using: :btree

    create_table 'trips', force: :cascade do |t|
      t.string   'name', limit: 255
      t.date     'start_date'
      t.date     'end_date'
      t.integer  'route_id'
      t.integer  'bus_id'
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.integer  'user_id'
      t.text     'notes'
      t.boolean  'archived', default: false
      t.datetime 'archived_at'
      t.integer  'bookings_count', default: 0
    end

    add_index 'trips', ['archived'], name: 'index_trips_on_archived', where: '(archived = false)', using: :btree
    add_index 'trips', ['bus_id'], name: 'index_trips_on_bus_id', using: :btree
    add_index 'trips', ['route_id'], name: 'index_trips_on_route_id', using: :btree

    create_table 'users', force: :cascade do |t|
      t.string   'email',                  limit: 255, default: '', null: false
      t.string   'encrypted_password',     limit: 255, default: '', null: false
      t.string   'reset_password_token',   limit: 255
      t.datetime 'reset_password_sent_at'
      t.datetime 'remember_created_at'
      t.integer  'sign_in_count', default: 0, null: false
      t.datetime 'current_sign_in_at'
      t.datetime 'last_sign_in_at'
      t.string   'current_sign_in_ip',     limit: 255
      t.string   'last_sign_in_ip',        limit: 255
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.string   'name',                   limit: 255
      t.string   'surname',                limit: 255
      t.integer  'role', default: 0
    end

    add_index 'users', ['email'], name: 'index_users_on_email', unique: true, using: :btree
    add_index 'users', ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true, using: :btree

    create_table 'venues', force: :cascade do |t|
      t.string   'name', limit: 255
      t.integer  'city_id'
      t.datetime 'created_at'
      t.datetime 'updated_at'
    end

    add_index 'venues', ['city_id'], name: 'index_venues_on_city_id', using: :btree

    create_table 'vouchers', force: :cascade do |t|
      t.string   'ref_no', limit: 255
      t.decimal  'amount'
      t.boolean  'active', default: true
      t.integer  'client_id'
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.integer  'user_id'
    end

    add_index 'vouchers', ['client_id'], name: 'index_vouchers_on_client_id', using: :btree
  end

  def self.down
    fail ActiveRecord::IrreversibleMigration
  end
end
