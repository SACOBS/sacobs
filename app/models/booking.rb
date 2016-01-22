# == Schema Information
#
# Table name: bookings
#
#  id                :integer          not null, primary key
#  trip_id           :integer
#  price             :decimal(, )      default(0.0)
#  status            :integer          default(0)
#  created_at        :datetime
#  updated_at        :datetime
#  quantity          :integer          default(1)
#  expiry_date       :datetime
#  client_id         :integer
#  user_id           :integer
#  reference_no      :string(255)
#  main_id           :integer
#  stop_id           :integer
#  sequence_id       :integer
#  archived          :boolean          default(FALSE)
#  archived_at       :datetime
#  payment_detail_id :integer
#
# Indexes
#
#  index_bookings_on_archived   (archived)
#  index_bookings_on_client_id  (client_id)
#  index_bookings_on_main_id    (main_id)
#  index_bookings_on_stop_id    (stop_id)
#  index_bookings_on_trip_id    (trip_id)
#

#
# Table name: bookings
#
#  id           :integer          not null, primary key
#  trip_id      :integer
#  price        :decimal(, )      default(0.0)
#  status       :integer          default(0)
#  created_at   :datetime
#  updated_at   :datetime
#  quantity     :integer          default(0)
#  expiry_date  :datetime
#  client_id    :integer
#  user_id      :integer
#  reference_no :string(255)
#  main_id      :integer
#  stop_id      :integer
#  sequence_id  :integer
#  archived     :boolean          default(FALSE)
#  archived_at  :datetime
#
# Indexes
#
#  index_bookings_on_archived   (archived)
#  index_bookings_on_client_id  (client_id)
#  index_bookings_on_main_id    (main_id)
#  index_bookings_on_stop_id    (stop_id)
#  index_bookings_on_trip_id    (trip_id)
#

class Booking < ActiveRecord::Base
  include Archivable

  default_scope { order(:created_at) }

  enum status: %i(in_process reserved paid cancelled)

  belongs_to :trip, counter_cache: true
  belongs_to :stop
  has_one :connection, through: :stop
  belongs_to :client
  belongs_to :payment_detail

  belongs_to :main, class_name: "Booking", foreign_key: :main_id
  has_one :return_booking, class_name: "Booking", foreign_key: :main_id

  has_one :invoice
  has_many :passengers, dependent: :delete_all

  accepts_nested_attributes_for :client, :passengers, :invoice, reject_if: :all_blank
  accepts_nested_attributes_for :return_booking, reject_if: :all_blank

  with_options if: :in_process? do
    validates :quantity, numericality: {greater_than: 0}
    validate :seats_are_available
  end

  scope :open, -> { reserved.where("expiry_date > ?", Time.current) }
  scope :standby, -> { reserved.where("expiry_date <= ?", Time.current) }
  scope :completed, -> { where.not(status: statuses[:in_process]) }

  ransacker(:created_at_date, type: :date) {|_parent| Arel::Nodes::SqlLiteral.new "date(bookings.created_at)" }

  before_save :set_passengers, if: :client_id_changed?
  after_save :synchronize_associations, if: :return_booking

  def return?
    main.present?
  end

  def standby?
    reserved? && expired?
  end

  def expired?
    expiry_date.past?
  end

  private

  def set_passengers
    passengers.clear
    quantity.times { passengers.build(name: client.name, surname: client.surname, cell_no: client.cell_no, email: client.email) }
  end

  def synchronize_associations
    return_booking.client = client
    return_booking.passengers = passengers.map(&:dup)
    return_booking.save
  end

  def seats_are_available
    if stop.present? && quantity > stop.available_seats
      errors.add(:quantity, "The number of seats #{quantity} selected exceeds the available seating #{stop.available_seats} for this connection.")
    end
  end
end
