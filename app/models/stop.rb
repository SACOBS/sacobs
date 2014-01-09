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

 scope :cost, -> { includes(:connection).sum('connections.cost')}
 scope :en_route, -> (destination) { joins(:trip,connection: [:to,:route]).where('destinations.sequence > ?', destination.sequence).readonly(false)}

 delegate :name, :from, :to, to: :connection

end

