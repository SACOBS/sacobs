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
#  user_id    :integer
#

class Trip < ActiveRecord::Base
  include AttributesEmpty

  belongs_to :user
  belongs_to :bus
  belongs_to :route, -> { includes(:connections) }
  has_many :stops , dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_and_belongs_to_many :drivers

  amoeba { enable }

  accepts_nested_attributes_for :stops, reject_if: :all_blank, allow_destroy: true

  delegate :name, :capacity, to: :bus, prefix: true, allow_nil: true

  validates :name, :start_date, :end_date, :route, :bus, presence: true, on: :update

  before_update :generate_stops, if: :route_id_changed?

  ransacker(:start_date, type: :date) { |parent| Arel::Nodes::SqlLiteral.new "date(trips.start_date)" }


  protected
   def generate_stops
     self.stops.clear
     self.route.connections.each { |connection| self.stops.build(connection: connection, available_seats: self.bus_capacity) }
   end
 end
