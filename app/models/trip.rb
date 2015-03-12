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
  include Archivable

  to_param :name

  belongs_to :user
  belongs_to :bus
  belongs_to :route

  has_and_belongs_to_many :drivers

  with_options dependent: :delete_all do |assoc|
    assoc.has_many :stops
    assoc.has_many :bookings
  end

  accepts_nested_attributes_for :stops, reject_if: :all_blank, allow_destroy: true

  delegate :name, :capacity, to: :bus, prefix: true, allow_nil: true
  delegate :name, to: :route, prefix: true, allow_nil: true

  validates :start_date, :end_date, :route, :bus, presence: true, on: :update

  before_save :set_name
  after_update :generate_stops, if: :route_id_changed?

  ransacker(:start_date, type: :date) { |_parent| Arel::Nodes::SqlLiteral.new 'date(trips.start_date)' }

  def copy
    copy = dup
    copy.name = "Copy of #{name}"
    copy.drivers = drivers.map(&:dup)
    copy.stops = stops.map(&:dup)
    copy
  end

  def assign_seats(stop, qty)
    transaction do
      stops.affected(stop).update_all(['available_seats = available_seats - ?', qty])
      touch
    end
  end

  def unassign_seats(stop, qty)
    transaction do
      stops.affected(stop).update_all(['available_seats = available_seats + ?', qty])
      touch
    end
  end

  private

  def defaults
    { start_date: Date.today, end_date: (start_date || Date.tomorrow) }
  end

  protected

  def set_name
    self.name = route_name.try(:squish) unless name.present?
  end

  def generate_stops
    transaction do
      stops.clear
      stops.create(route.connections.map { |connection| { connection: connection, available_seats: bus_capacity, depart: connection.depart, arrive: connection.arrive } })
    end
  end
 end
