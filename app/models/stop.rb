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

 belongs_to :trip, touch: true
 belongs_to :connection

 scope :departing, -> (from_city) { joins(connection: :from_city).where(cities: {id: from_city}) }

 scope :destination, -> (to_city) { joins(connection: :to_city).where(cities: {id: to_city}) }

 scope :en_route, -> (from, to) { where('id >= ? AND id <= ?', from, to) }

 delegate :from_city, :to_city, to: :connection


end

