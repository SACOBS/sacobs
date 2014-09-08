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

  with_options dependent: :delete_all, inverse_of: :trip do |assoc|
   assoc.has_many :stops
   assoc.has_many :bookings
  end

  has_and_belongs_to_many :drivers, before_add: :touch_parent, before_remove: :touch_parent

  amoeba do
    enable
    prepend name: 'Copy of'
    include_field [:stops]
  end

  accepts_nested_attributes_for :stops, reject_if: :all_blank, allow_destroy: true

  delegate :name, :capacity, to: :bus, prefix: true, allow_nil: true

  validates :name, :start_date, :end_date, :route, :bus, presence: true, on: :update

  before_update :generate_stops, if: :route_id_changed?

  ransacker(:start_date, type: :date) { |parent| Arel::Nodes::SqlLiteral.new "date(trips.start_date)" }

  scope :valid, -> { where(trip[:start_date].gteq(Date.today)) }
  scope :complete, -> { where.not(trip[:route_id].eq(nil))}
  scope :archived, -> { where(trip[:start_date].lteq(Date.today)) }
  scope :from_location, -> (location) { joins(route: :destinations).where(destinations: { city_id: location, sequence: 1 } ) }


  def self.trip
    self.arel_table
  end
  private_class_method :trip

  private
   def defaults
     { start_date: Date.today, end_date: (self.start_date || Date.tomorrow) }
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
