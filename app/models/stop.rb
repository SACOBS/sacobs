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

 scope :from, -> (city){ joins(connection: :from_city).where('connections.from_city_id = cities.id AND cities.id = ?', city.id) }
 scope :to, -> (city){ joins(connection: :to_city).where('connections.to_city_id = cities.id AND cities.id = ?', city.id) }

 scope :en_route, -> (from, to) { where('id >= ? AND id <= ?', from, to) }


end

