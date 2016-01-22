# == Schema Information
#
# Table name: stops
#
#  id              :integer          not null, primary key
#  connection_id   :integer
#  trip_id         :integer
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
  belongs_to :connection

  has_many :bookings

  delegate :name,
           :from_city_name,
           :from_city_venues,
           :to_city_name,
           :to_city_venues,
           :leaving,
           :arriving,
           to: :connection

  scope :along_the_way, lambda { |from, to|
                          joins(connection: :to)
                            .where("connections.from_id != ? and destinations.sequence > ?", to, from.sequence)
                        }

  def self.assign_seats(quantity)
    update_all(["available_seats = available_seats - ?", quantity])
  end

  def self.unassign_seats(quantity)
    update_all(["available_seats = available_seats + ?", quantity])
  end
end
