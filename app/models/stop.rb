# == Schema Information
#
# Table name: stops
#
#  id              :integer          not null, primary key
#  connection_id   :integer
#  trip_id         :integer
#  available_seats :integer
#  created_at      :timestamp withou
#  updated_at      :timestamp withou
#
# Indexes
#
#  index_stops_on_connection_id  (connection_id)
#  index_stops_on_trip_id        (trip_id)
#

class Stop < ActiveRecord::Base
  belongs_to :trip, -> { unscope(where: :archived) }
  belongs_to :connection, -> { includes(from: :city, to: :city) }
  has_many :bookings

  delegate :from_city_name, :to_city_name, to: :connection

  scope :affected, -> (stop) { includes(:trip).joins(connection: :to).where('connections.from_id != ? and destinations.sequence > ?', stop.connection.to, stop.connection.from.sequence) }
end
