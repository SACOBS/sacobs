# == Schema Information
#
# Table name: stops
#
#  id              :integer          not null, primary key
#  connection_id   :integer
#  trip_id         :integer
#  arrive          :datetime
#  depart          :datetime
#  available_seats :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class Stop < ActiveRecord::Base

 belongs_to :trip
 belongs_to :connection
 has_and_belongs_to_many :bookings


 scope :departing, -> (from_city) { joins(connection: :from_city).where(cities: {id: from_city}) }

 scope :destination, -> (to_city) { joins(connection: :to_city).where(cities: {id: to_city}) }

 scope :en_route, -> (from, to) { where('id >= ? AND id <= ?', from, to) }

 scope :cost, -> { includes(:connection).sum('connections.cost')}

 delegate :from_city, :to_city, to: :connection


end

