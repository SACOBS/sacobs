# == Schema Information
#
# Table name: bookings
#
#  id           :integer          not null, primary key
#  trip_id      :integer
#  price        :numeric          default(0.0)
#  status       :integer          default(0)
#  created_at   :timestamp withou
#  updated_at   :timestamp withou
#  quantity     :integer          default(0)
#  expiry_date  :timestamp withou
#  client_id    :integer
#  user_id      :integer
#  reference_no :character varyin
#  main_id      :integer
#  has_return   :boolean          default(FALSE)
#  stop_id      :integer
#  sequence_id  :integer
#  archived     :boolean          default(FALSE)
#  archived_at  :timestamp withou
#
# Indexes
#
#  index_bookings_on_archived   (archived)
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
  belongs_to :trip, -> { unscope(where: :archived) }, counter_cache: true
  belongs_to :stop, -> { includes(:connection) }
  belongs_to :client
  belongs_to :main,  -> { unscope(where: :archived) }, class_name: 'Booking', foreign_key: :main_id

  has_one :return_booking, -> { unscope(where: :archived) }, class_name: 'Booking', foreign_key: :main_id, dependent: :destroy
  has_one :invoice, dependent: :delete
  has_one :payment_detail, dependent: :delete

  has_many :passengers, -> { includes(:passenger_type) }, dependent: :delete_all

  accepts_nested_attributes_for :client, :passengers, :invoice
  accepts_nested_attributes_for :return_booking, reject_if: :all_blank

  validates :quantity, numericality: { greater_than: 0 }
  validate :quantity_available, if: :stop

  before_create :generate_reference
  before_create :set_expiry_date

  scope :open, -> { where(arel_table[:expiry_date].gt(Time.current)) }
  scope :expired, -> { where(arel_table[:expiry_date].lteq(Time.current)) }
  scope :recent, -> { unscoped.includes(:stop).processed.order(created_at: :desc).limit(5) }
  scope :processed, -> { where(arel_table[:status].not_eq(statuses[:in_process])) }
  scope :for_today, -> { where(created_at: Time.now.midnight..Time.now.end_of_day) }
  scope :travelling, -> { where(arel_table[:status].eq(statuses[:reserved]).or(arel_table[:status].eq(statuses[:paid]))) }

  ransacker(:created_at_date, type: :date) { |_parent| Arel::Nodes::SqlLiteral.new 'date(bookings.created_at)' }

  delegate :total, :total_cost, :total_discount, to: :invoice, prefix: true
  delegate :start_date, to: :trip, prefix: true, allow_nil: true

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

  def build_passengers
    passengers.clear if passengers.any?
    quantity.times { passengers.build(name: client.name, surname: client.surname, cell_no: client.cell_no, email: client.email) }
  end

  def build_invoices
    price = stop.connection.cost
    [self, return_booking].compact.each do |booking|
      invoice = booking.build_invoice
      booking.passengers.each do |passenger|
        invoice.line_items.build(description: "#{passenger.full_name} ticket", amount: price, line_item_type: :debit)

        # Additional Charges
        total_charges = 0
        passenger.charges.each do |charge|
          description = "#{charge.description} charge - #{charge.percentage.round}%".capitalize
          amount = Calculations.roundup(price * (charge.percentage.to_f / 100))
          total_charges += amount
          invoice.line_items.build(description: description, amount: amount, line_item_type: :debit)
        end

        # Discount
        discount = SeasonalDiscount.active_in_period(Date.current).find_by(passenger_type: passenger.passenger_type) || passenger.discount
        description = "#{discount.passenger_type.description} discount (#{discount.percentage.round}%)".capitalize
        amount = ((price + total_charges) * (discount.percentage.to_f / 100)).round
        invoice.line_items.build(description: description, amount: amount, line_item_type: :credit)
      end
    end
  end

  private

  def generate_reference
    self.sequence_id = self.class.connection.select_value("SELECT nextval('sequence_id_seq')")
    self.reference_no = "#{SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz')[0..4].upcase}#{'%03d' % sequence_id}"
  end

  def set_expiry_date
    self.expiry_date = Time.current.advance(hours: Setting.first.booking_expiry_period)
  end

  def quantity_available
    errors.add(:quantity, 'The number of seats selected exceeds the available seating on the bus for this connection.') unless quantity <= stop.available_seats
  end
end
