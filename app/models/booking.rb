# == Schema Information
#
# Table name: bookings
#
#  id           :integer          not null, primary key
#  trip_id      :integer
#  price        :decimal(, )
#  status       :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  quantity     :integer          default(0)
#  expiry_date  :datetime
#  client_id    :integer
#  user_id      :integer
#  reference_no :string(255)
#  main_id      :integer
#  has_return   :boolean          default(FALSE)
#  stop_id      :integer
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

  enum :status, [:paid, :reserved, :cancelled, :in_process]

  attr_accessor :expired

  belongs_to :user
  belongs_to :trip
  belongs_to :stop
  belongs_to :client
  belongs_to :main, ->{ where.not(status: :cancelled) } ,class_name: :Booking, foreign_key: :main_id, touch: true
  has_one :return_booking, ->{ where.not(status: :cancelled) } ,class_name: :Booking, foreign_key: :main_id
  has_one :invoice, dependent: :destroy
  has_one :payment_detail, dependent: :destroy
  has_many :passengers, dependent: :destroy

  accepts_nested_attributes_for :client, reject_if: proc { |attributes| attributes.blank? }
  accepts_nested_attributes_for :passengers, reject_if: :all_blank
  accepts_nested_attributes_for :invoice, reject_if: :all_blank
  accepts_nested_attributes_for :return_booking, reject_if: :all_blank

  delegate :name, :start_date, :end_date, to: :trip, prefix: true

  validates :quantity, numericality: { greater_than: 0 }
  validate :quantity_available, if: :stop

  before_save :init_return_booking, prepend: true
  before_save :set_shared_booking_data
  before_save :generate_reference
  after_find :check_expiration


  ransacker(:created_at_date, type: :date) { |parent| Arel::Nodes::SqlLiteral.new "date(bookings.created_at)" }

  scope :active, -> { joins(:trip).merge(Trip.valid) }
  scope :standby, -> { reserved.where('expiry_date <= ?', Time.zone.now) }


  def is_return?
    self.main_id?
  end


  private
    def defaults
      { status: 'in_process' }
    end


  protected
    def quantity_available
      self.errors.add(:quantity,'The number of seats selected exceeds the available seating on the bus for this connection.') unless quantity <= stop.available_seats
    end

    def init_return_booking
      self.build_return_booking(quantity: self.quantity) if has_return? && !return_booking
    end

    def set_shared_booking_data
      if return_booking
        return_booking.client_id = client_id unless return_booking.client_id.present?
        passengers.each {|p| return_booking.passengers << p.dup } unless return_booking.passengers.any?
      end
    end

    def generate_reference
      if reserved?
       self.sequence_id = SequenceGenerator.new(self).execute unless sequence_id.present?
       self.reference_no = "#{SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz')[0..4].upcase}#{"%03d" % sequence_id}" unless reference_no.present?
      end
    end

    def check_expiration
      self.expired = (expiry_date <= Time.zone.now) rescue false
    end
end
