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

  has_and_belongs_to_many :drivers

  with_options dependent: :delete_all do |assoc|
    assoc.has_many :stops
    assoc.has_many :bookings
  end

  amoeba do
    enable
    prepend name: 'Copy of'
  end

  accepts_nested_attributes_for :stops, reject_if: :all_blank, allow_destroy: true

  delegate :name, :capacity, to: :bus, prefix: true, allow_nil: true
  delegate :name, to: :route, prefix: true, allow_nil: true

  validates :name, :start_date, :end_date, :route, :bus, presence: true, on: :update

  before_save :set_name, if: :route_id_changed?
  before_update :generate_stops, if: :route_id_changed?

  ransacker(:start_date, type: :date) { |_parent| Arel::Nodes::SqlLiteral.new 'date(trips.start_date)' }

  scope :valid, -> { where(arel_table[:start_date].gteq(Date.today)) }
  scope :archived, -> { where(arel_table[:start_date].lteq(Date.today)) }

  private

  def defaults
    { start_date: Date.today, end_date: (start_date || Date.tomorrow) }
  end

  protected

  def set_name
    self.name = route.name.trim
  end

  def generate_stops
    stops.clear
    route.connections.each { |connection| stops.build(connection: connection, available_seats: bus_capacity, depart: connection.depart, arrive: connection.arrive) }
  end
 end
