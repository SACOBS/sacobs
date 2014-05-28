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
#  notes      :text
#
# Indexes
#
#  index_trips_on_bus_id    (bus_id)
#  index_trips_on_route_id  (route_id)
#  index_trips_on_user_id   (user_id)
#

class Trip < ActiveRecord::Base

  belongs_to :user
  belongs_to :bus
  belongs_to :route
  has_many :stops , dependent: :destroy, inverse_of: :trip
  has_many :bookings, dependent: :destroy
  has_and_belongs_to_many :drivers, before_add: :touch_parent, before_remove: :touch_parent

  amoeba do
    prepend name: 'Copy of'
    enable
  end

  accepts_nested_attributes_for :stops, reject_if: :all_blank, allow_destroy: true

  delegate :name, :capacity, to: :bus, prefix: true, allow_nil: true

  validates :name, :start_date, :end_date, :route, :bus, presence: true, on: :update

  validates :route, :bus, uniqueness: {scope: :start_date},on: :update

  before_update :generate_stops, if: :route_id_changed?

  ransacker(:start_date, type: :date) { |parent| Arel::Nodes::SqlLiteral.new "date(trips.start_date)" }

  scope :valid, -> { where(arel_table[:start_date].gteq(Date.today)) }
  scope :archived, -> { where(arel_table[:start_date].lteq(Date.today)) }
  scope :from_location, -> (location) { joins(route: :destinations).where(destinations: { city_id: location, sequence: 1 } ) }

  private
   def defaults
     { start_date: Date.today, end_date: Date.today }
   end

  protected
   def touch_parent(driver)
     self.touch
   end

   def generate_stops
     self.stops.clear
     self.route.connections.each { |connection| self.stops.build(connection: connection, available_seats: self.bus_capacity, depart: connection.depart, arrive: connection.arrive) }
   end
 end
