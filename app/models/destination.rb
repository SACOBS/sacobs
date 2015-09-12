# == Schema Information
#
# Table name: destinations
#
#  id         :integer          not null, primary key
#  route_id   :integer
#  city_id    :integer
#  sequence   :integer
#  created_at :datetime
#  updated_at :datetime
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

  belongs_to :city, required: true, inverse_of: :destinations
  belongs_to :route, required: true, inverse_of: :destinations

  delegate :name, :venues, to: :city, prefix: true

  validates :sequence, presence: true, numericality: true
  validates :city, uniqueness: { scope: :route, message: 'already exists for this route.' }
end
