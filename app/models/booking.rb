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

  enum status: [:in_process, :reserved, :paid, :cancelled]

  belongs_to :trip, -> { unscope(where: :archived) }, counter_cache: true
  belongs_to :stop, -> { includes(:connection) }
  belongs_to :client

  belongs_to :main, -> { unscope(where: :archived) }, class_name: 'Booking', foreign_key: :main_id
  has_one :return_booking, -> { unscope(where: :archived) }, class_name: 'Booking', foreign_key: :main_id, autosave: true

  has_one :invoice, dependent: :delete
  has_one :payment_detail, dependent: :delete

  has_many :passengers, -> { includes(:passenger_type) }, dependent: :delete_all

  accepts_nested_attributes_for :client, :passengers, :invoice
  accepts_nested_attributes_for :return_booking, reject_if: :all_blank

  validates :quantity, numericality: { greater_than: 0 }
  validate :quantity_available, if: :stop

  after_initialize :set_defaults, if: :new_record?
  before_create :generate_reference_no

  before_save :clear_passengers, if: :client_id_changed?
  before_save :update_return_booking, if: :return_booking
  before_save :assign_seats, :reserve_return_booking, if: proc { |booking| booking.status_changed? && booking.reserved? }
  before_save :unassign_seats, if: proc { |booking| booking.status_changed? && booking.cancelled? }
  before_save :reserve_return_booking, if: proc { |booking| booking.respond_to?(:return_booking) && booking.return_booking && booking.status_changed? && booking.reserved? }

  scope :open, -> { reserved.where('expiry_date > ?', Time.current) }
  scope :expired, -> { reserved.where('expiry_date <= ?', Time.current) }
  scope :recent, -> { unscoped.includes(:stop).processed.order(created_at: :desc).limit(5) }
  scope :processed, -> { where.not(status: statuses[:in_process]) }
  scope :travelling, -> { where(status: [statuses[:reserved], statuses[:paid]]) }

  ransacker(:created_at_date, type: :date) { |_parent| Arel::Nodes::SqlLiteral.new 'date(bookings.created_at)' }

  def standby?
    reserved? && expired?
  end

  def expired?
    expiry_date.past?
  end

  def build_passengers
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

  def set_defaults
    self.quantity = 1
    self.sequence_id = self.class.connection.select_value("SELECT nextval('sequence_id_seq')")
  end

  def assign_seats
    trip.assign_seats(stop, quantity)
  end

  def unassign_seats
    trip.unassign_seats(stop, quantity)
  end

  def clear_passengers
    passengers.clear
  end

  def update_return_booking
    return_booking.client = client
    return_booking.passengers = passengers.map(&:dup)
  end

  def reserve_return_booking
    return_booking.expiry_date = expiry_date
    return_booking.status = :reserved
  end

  def generate_reference_no
    self.reference_no = "#{SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz')[0..4].upcase.concat('%03d' % sequence_id)}"
  end

  def quantity_available
    errors.add(:quantity, 'The number of seats selected exceeds the available seating on the bus for this connection.') unless quantity <= stop.available_seats
  end
end
