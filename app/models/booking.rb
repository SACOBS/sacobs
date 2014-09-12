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
#  quantity     :integer          default(0)
#  expiry_date  :datetime
#  client_id    :integer
#  user_id      :integer
#  reference_no :string(255)
#  main_id      :integer
#  has_return   :boolean          default(FALSE)
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

  attr_accessor :expired, :charges

  belongs_to :user
  belongs_to :trip, inverse_of: :bookings
  belongs_to :stop
  belongs_to :client

  belongs_to :main, class_name: 'Booking', foreign_key: :main_id
  has_one :return_booking, class_name: 'Booking', foreign_key: :main_id, dependent: :delete, autosave: true

  has_many :passengers, dependent: :delete_all


  has_one :invoice, dependent: :delete
  has_one :payment_detail, dependent: :delete

  accepts_nested_attributes_for :client, :passengers, :invoice, :return_booking, reject_if: :all_blank
  accepts_nested_attributes_for :return_booking, reject_if: :all_blank

  delegate :name, :start_date, :end_date, to: :trip, prefix: true

  validates :quantity, numericality: { greater_than: 0 }
  validate :quantity_available, if: :stop

  before_save :generate_reference
  after_find :check_expiration


  scope :active, -> { joins(:trip).merge(Trip.valid) }
  scope :standby, -> { reserved.where('expiry_date <= ?', Time.zone.now) }
  scope :not_in_process, -> { where("status <> ?", Booking.statuses[:in_process]) }

  ransacker(:created_at_date, type: :date) { |parent| Arel::Nodes::SqlLiteral.new "date(bookings.created_at)" }

  def is_return?
    main_id?
  end

  private
    def defaults
      { status: :in_process }
    end

    def quantity_available
      self.errors.add(:quantity,'The number of seats selected exceeds the available seating on the bus for this connection.') unless quantity <= stop.available_seats
    end


  protected
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
