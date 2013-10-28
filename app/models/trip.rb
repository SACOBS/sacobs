# == Schema Information
#
# Table name: trips
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  start_date :date
#  end_date   :date
#  route_id   :integer
#  bus_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

class Trip < ActiveRecord::Base
  include AttributesEmpty

  belongs_to :bus
  belongs_to :route, -> { includes(:connections) }
  has_many :stops , dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_and_belongs_to_many :drivers

  amoeba { enable }

  accepts_nested_attributes_for :stops, reject_if: :all_blank, allow_destroy: true

  delegate :description, to: :route, prefix: true, allow_nil: true
  delegate :name, to: :bus, prefix: true, allow_nil: true

  validates :name, :start_date, :end_date, :route, :bus, presence: true

  def from
    stops.first.from_city
  end

  def to
    stops.last.to_city
  end

  def available_stops(from, to)
    departing = self.stops.departing(from).first
    destination = self.stops.destination(to).first
    self.stops.en_route(departing, destination)
  end
 end
