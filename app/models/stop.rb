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
  belongs_to :trip, -> { unscope(where: :archived) }
  belongs_to :connection, -> { includes(from: :city, to: :city) }
  has_many :bookings

  delegate :arrive, :depart, :from_city_name, :to_city_name, to: :connection

  scope :affected, -> (stop) { includes(:trip).joins(connection: :to).where('connections.from_id != ? and destinations.sequence > ?', stop.connection.to, stop.connection.from.sequence) }

  private

  def defaults
    { arrive: Time.current, depart: Time.current }
  end
end
