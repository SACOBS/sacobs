# == Schema Information
#
# Table name: bookings
#
#  id           :integer          not null, primary key
#  trip_id      :integer
#  price        :decimal(, )
#  status       :integer
#  created_at   :datetime
#  updated_at   :datetime
#  quantity     :integer
#  expiry_date  :datetime
#  client_id    :integer
#  user_id      :integer
#  reference_no :string(255)
#  main_id      :integer
#  has_return   :boolean
#  stop_id      :integer
#  sequence_id  :integer
#
# Indexes
#
#  index_bookings_on_client_id  (client_id)
#  index_bookings_on_main_id    (main_id)
#  index_bookings_on_stop_id    (stop_id)
#  index_bookings_on_trip_id    (trip_id)
#  index_bookings_on_user_id    (user_id)
#

class Booking < ActiveRecord::Base
  include Archivable

  enum status: [:in_process, :reserved, :paid, :cancelled]

  belongs_to :user
  belongs_to :trip, counter_cache: true
  belongs_to :stop
  belongs_to :client
  belongs_to :main, class_name: 'Booking', foreign_key: :main_id

  has_one :return_booking, class_name: 'Booking', foreign_key: :main_id
  has_one :invoice, dependent: :delete
  has_one :payment_detail, dependent: :delete

  has_many :passengers, dependent: :delete_all

  accepts_nested_attributes_for :client, :passengers, :invoice
  accepts_nested_attributes_for :return_booking, reject_if: :all_blank

  delegate :arrive, :depart, :from_city, :to_city, :from_city_name, :to_city_name, to: :stop, allow_nil: true
  delegate :payment_type, :payment_date, :reference, to: :payment_detail, prefix: true, allow_nil: true
  delegate :total, :total_cost, :total_discount, to: :invoice, prefix: true, allow_nil: true
  delegate :name, :start_date, :end_date, to: :trip, prefix: true, allow_nil: true
  delegate :name, :surname, :full_name, :home_no, :cell_no, :email, :work_no, :age, :is_pensioner?, :bank, :id_number, :date_of_birth, to: :client, prefix: true

  validates :quantity, numericality: { greater_than: 0 }
  validate :quantity_available, if: :stop

  after_initialize :set_defaults, if: :new_record?


  scope :processed, -> { where(arel_table[:status].not_eq(statuses[:in_process])) }
  scope :for_today, -> { where(created_at: Time.now.midnight..Time.now.end_of_day) }
  scope :travelling, -> { where(arel_table[:status].eq(statuses[:reserved]).or(arel_table[:status].eq(statuses[:paid]))) }

  ransacker(:created_at_date, type: :date) { |_parent| Arel::Nodes::SqlLiteral.new 'date(bookings.created_at)' }

  def open?
    reserved? && !expired?
  end

  def standby?
    reserved? && expired?
  end

  def expired?
    expiry_date? && (expiry_date <= Time.current)
  end

  def reserve
    transaction do
      trip.assign_seats(stop, quantity)
      reserved!
    end
  end

  def cancel
    transaction do
      trip.unassign_seats(stop, quantity)
      cancelled!
    end
  end

  def client
    super || build_client
  end

  private

  def set_defaults
    self.status = :in_process
    self.price = 0
    self.quantity = 1
    self.has_return = false
    self.sequence_id = self.class.connection.select_value("SELECT nextval('sequence_id_seq')")
    self.reference_no = "#{SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz')[0..4].upcase}#{'%03d' % sequence_id}"
    self.expiry_date = Time.current.advance(hours: Setting.first.booking_expiry_period)
  end

  def quantity_available
    errors.add(:quantity, 'The number of seats selected exceeds the available seating on the bus for this connection.') unless quantity <= stop.available_seats
  end
end
