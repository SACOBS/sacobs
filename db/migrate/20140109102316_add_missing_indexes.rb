class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :bookings, :user_id
    add_index :bookings, :trip_id
    add_index :bookings, :client_id
    add_index :bookings_stops, [:stop_id, :booking_id]
    add_index :bookings_stops, [:booking_id, :stop_id]
    add_index :buses, :user_id
    add_index :destinations, :city_id
    add_index :destinations, :route_id
    add_index :destinations, [:city_id, :route_id]
    add_index :line_items, :invoice_id
    add_index :venues, :city_id
    add_index :vouchers, :client_id
    add_index :vouchers, :user_id
    add_index :addresses, [:addressable_id, :addressable_type]
    add_index :cities, :user_id
    add_index :clients, :user_id
    add_index :connections, :route_id
    add_index :connections, :from_id
    add_index :connections, :to_id
    add_index :routes, :user_id
    add_index :discounts, :passenger_type_id
    add_index :discounts, :user_id
    add_index :drivers, :user_id
    add_index :drivers_trips, [:trip_id, :driver_id]
    add_index :drivers_trips, [:driver_id, :trip_id]
    add_index :invoices, :booking_id
    add_index :passengers, :booking_id
    add_index :passengers, :passenger_type_id
    add_index :stops, :trip_id
    add_index :stops, :connection_id
    add_index :trips, :user_id
    add_index :trips, :bus_id
    add_index :trips, :route_id
  end
end
