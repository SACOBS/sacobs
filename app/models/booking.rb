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
#  quantity          :integer          default(0)
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

  enum status: [:in_process, :reserved, :paid, :cancelled]

  belongs_to :trip, counter_cache: true
  belongs_to :stop
  belongs_to :client
  belongs_to :payment_detail


  belongs_to :main, class_name: 'Booking', foreign_key: :main_id
  has_one :return_booking, class_name: 'Booking', foreign_key: :main_id

  has_one :invoice

  has_many :passengers

  accepts_nested_attributes_for :client, :passengers, :invoice
  accepts_nested_attributes_for :return_booking, reject_if: :all_blank

  with_options if: :in_process? do
    validates :quantity, numericality: { greater_than: 0 }
    validate :seats_are_available
  end

  scope :open, -> { available.reserved.where('expiry_date > ?', Time.current) }
  scope :expired, -> { available.reserved.where('expiry_date <= ?', Time.current) }
  scope :completed, -> { where.not(status: statuses[:in_process]) }

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

  def calculate_costs
    invoice = build_invoice
    price = stop.connection.cost
    passengers.each do |passenger|
      invoice.line_items.build(description: "#{passenger.full_name} ticket", amount: price, line_item_type: :debit)

      # Additional Charges
      total_charges = 0
      passenger.charges.each do |charge|
        description = "#{charge.description} charge - #{charge.percentage}%".capitalize
        amount = charge.percentage.percent_of(price).round_up(5)
        total_charges += amount
        invoice.line_items.build(description: description, amount: amount, line_item_type: :debit)
      end

      # Discount
      discount = SeasonalDiscount.active_in_period(Date.current).find_by(passenger_type: passenger.passenger_type) || passenger.discount
      description = "#{passenger.passenger_type.description} discount (#{discount.percentage}%)".capitalize
      total_cost = price + total_charges
      amount = discount.percentage.percent_of(total_cost).round_up(5)
      invoice.line_items.build(description: description, amount: amount, line_item_type: :credit)
    end
  end

  private

  def seats_are_available
    if stop.present? && quantity > stop.available_seats
      errors.add(:quantity, "The number of seats #{quantity} selected exceeds the available seating #{stop.available_seats} for this connection.")
    end
  end
end
