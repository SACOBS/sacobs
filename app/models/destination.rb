# == Schema Information
#
# Table name: destinations
#
#  id         :integer          not null, primary key
#  route_id   :integer
#  city_id    :integer
#  sequence   :integer
#  created_at :timestamp withou
#  updated_at :timestamp withou
#
# Indexes
#
#  index_destinations_on_city_id               (city_id)
#  index_destinations_on_city_id_and_route_id  (city_id,route_id)
#  index_destinations_on_route_id              (route_id)
#  index_destinations_on_sequence              (sequence)
#

class Destination < ActiveRecord::Base
  default_scope { order(sequence: :asc) }

  belongs_to :city, required: true
  belongs_to :route, required: true, inverse_of: :destinations

  has_many :connections, inverse_of: :from
  has_many :connections, inverse_of: :to

  validates :sequence, presence: true
  validates :city, uniqueness: { scope: :route, message: 'already exists for this route.' }

  delegate :name, :venues, to: :city, prefix: true
end
