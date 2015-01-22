# == Schema Information
#
# Table name: stops
#
#  id              :integer          not null, primary key
#  connection_id   :integer
#  trip_id         :integer
#  arrive          :time
#  depart          :time
#  available_seats :integer
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_stops_on_connection_id  (connection_id)
#  index_stops_on_trip_id        (trip_id)
#

class Stop < ActiveRecord::Base
  belongs_to :trip
  belongs_to :connection, -> { includes(:from, :to) }
  has_many :bookings

  scope :valid, -> { joins(:trip).merge(Trip.valid) }
  scope :affected,  -> (stop) { includes(:trip).joins(connection: :to).where('connections.from_id != ? and destinations.sequence > ?', stop.connection.to, stop.connection.from.sequence ) }

  delegate :name, :from_city, :to_city, :from_city_id, :from_city_name, :to_city_id, :to_city_name, :cost, to: :connection

  delegate :name, :start_date, to: :trip, prefix: true

  private

  def defaults
    { arrive: Time.current, depart: Time.current }
  end
end
