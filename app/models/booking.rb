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
  enum status: [:in_process, :reserved, :paid, :cancelled]

  belongs_to :user
  belongs_to :trip
  belongs_to :stop
  belongs_to :client
  belongs_to :main, class_name: 'Booking', foreign_key: :main_id

  has_one :return_booking, class_name: 'Booking', foreign_key: :main_id, dependent: :delete, autosave: true
  has_one :invoice, dependent: :delete
  has_one :payment_detail, dependent: :delete

  has_many :passengers, dependent: :delete_all do
    def build(attributes = {}, &block)
      attributes.merge! name: proxy_association.owner.client_name,
                        surname: proxy_association.owner.client_surname,
                        cell_no: proxy_association.owner.client_cell_no,
                        email: proxy_association.owner.client_email
      super(attributes, &block)
    end
  end

  accepts_nested_attributes_for :client, :passengers, :invoice
  accepts_nested_attributes_for :return_booking, reject_if: :all_blank

  delegate :arrive, :depart, :from_city, :to_city, :from_city_name, :to_city_name, to: :stop
  delegate :payment_type, :payment_date, :reference, to: :payment_detail, prefix: true, allow_nil: true
  delegate :total, :total_cost, :total_discount, to: :invoice, prefix: true
  delegate :name, :start_date, :end_date, to: :trip, prefix: true
  delegate :name, :surname, :full_name, :home_no, :cell_no, :email, :work_no, :age, :is_pensioner?, :bank_name, :id_number, :date_of_birth, to: :client, prefix: true

  validates :quantity, numericality: { greater_than: 0 }
  validate :quantity_available, if: :stop

  before_save :generate_reference
  before_save :save_client
  after_find :setup_return_booking, if: :has_return?

  scope :active, -> { joins(:trip).merge(Trip.valid) }
  scope :not_in_process, -> { where(arel_table[:status].not_eq(statuses[:in_process])) }
  scope :for_today, -> { where(created_at: Time.now.midnight..Time.now.end_of_day) }
  scope :travelling, -> { where(arel_table[:status].eq(statuses[:reserved]).or(arel_table[:status].eq(statuses[:paid]))) }

  ransacker(:created_at_date, type: :date) { |_parent| Arel::Nodes::SqlLiteral.new 'date(bookings.created_at)' }

  def sync_return_booking
    return unless has_return?
    return_booking.client = client
    return_booking.passengers.clear
    passengers.each { |passenger| return_booking.passengers << passenger.dup }
    return_booking.save!
  end

  def is_return?
    main_id?
  end

  def open?
    reserved? && !expired?
  end

  def standby?
    reserved? && expired?
  end

  def expired?
    expiry_date? && (expiry_date <= Time.zone.now)
  end

  def client
    super || build_client
  end

  def client_attributes=(attributes)
    self.client = Client.where(name: attributes['name'].upcase, surname: attributes['surname'].upcase).first_or_initialize
    super
  end

  private

  def defaults
    { status: :in_process, price: 0, quantity: 1, has_return: false }
  end

  def quantity_available
    errors.add(:quantity, 'The number of seats selected exceeds the available seating on the bus for this connection.') unless quantity <= stop.available_seats
  end

  protected

  def save_client
    client.save if client.present? && !client.new_record?
  end

  def setup_return_booking
    build_return_booking unless return_booking.present? && has_return?
  end

  def generate_reference
    if reserved?
      self.sequence_id = SequenceGenerator.new(self).execute unless sequence_id?
      self.reference_no = "#{SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz')[0..4].upcase}#{'%03d' % sequence_id}" unless reference_no?
    end
  end
end
