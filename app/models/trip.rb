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
  include Archivable

  to_param :name

  belongs_to :bus
  belongs_to :route

  has_and_belongs_to_many :drivers

  has_many :stops, dependent: :delete_all
  has_many :bookings, -> { unscope(where: :archived).processed }

  accepts_nested_attributes_for :stops

  validates :start_date, :end_date, :route, :bus, presence: true
  validates :drivers, length: { minimum: 1, too_short: 'minimum of 1 driver required' }

  ransacker(:start_date, type: :date) { |_parent| Arel::Nodes::SqlLiteral.new 'date(trips.start_date)' }

  delegate :name, to: :route, prefix: true
  delegate :name, to: :bus, prefix: true


  def to_file_name
    "#{name}_#{Time.current.to_i}".tr(' ', '_').downcase
  end

  def booked?
    bookings.any?
  end

  def drivers_names
    drivers.map(&:full_name).join(',')
  end
 end
