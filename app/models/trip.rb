# == Schema Information
#
# Table name: trips
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  start_date     :date
#  end_date       :date
#  route_id       :integer
#  bus_id         :integer
#  created_at     :datetime
#  updated_at     :datetime
#  user_id        :integer
#  notes          :text
#  archived       :boolean          default(FALSE)
#  archived_at    :datetime
#  bookings_count :integer          default(0)
#
# Indexes
#
#  index_trips_on_archived  (archived)
#  index_trips_on_bus_id    (bus_id)
#  index_trips_on_route_id  (route_id)
#  index_trips_on_user_id   (user_id)
#

class Trip < ActiveRecord::Base
  include Archivable, CollectionCacheable

  to_param :name

  belongs_to :user
  belongs_to :bus
  belongs_to :route

  has_and_belongs_to_many :drivers

  has_many :stops, -> { includes(:connection) }, dependent: :destroy
  has_many :bookings, -> { unscope(where: :archived).includes(:client, :stop).processed }, dependent: :destroy

  accepts_nested_attributes_for :stops

  validates :start_date, :end_date, :route, :bus, presence: true
  validates :drivers, length: { minimum: 1, too_short: 'minimum of 1 driver required' }

  before_create :set_name
  after_save :generate_stops, if: :route_id_changed?

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

  def to_file_name
    "#{name}_#{Time.current.to_i}".gsub(' ', '_').downcase
  end

  def booked?
    bookings.present?
  end

  protected

  def set_name
    self.name ||= route.name
  end

  def generate_stops
    self.class.no_touching do
      stops.clear if stops.present?
      stops.create!(route.connections.map { |connection| { connection: connection, available_seats: bus.capacity }})
    end
  end
 end
