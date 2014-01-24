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
#  index_bookings_on_trip_id    (trip_id)
#  index_bookings_on_user_id    (user_id)
#

class Booking < ActiveRecord::Base
  include AttributeDefaults

  enum :status, [:paid, :reserved, :cancelled, :in_process]

  belongs_to :user
  belongs_to :trip
  belongs_to :stop
  belongs_to :client
  belongs_to :main, class_name: :Booking, foreign_key: :main_id
  has_one :return, class_name: :Booking, foreign_key: :main_id, dependent: :destroy
  has_one :invoice, -> {includes(:line_items)}, dependent: :destroy
  has_one :payment_detail, dependent: :destroy
  has_many :passengers, dependent: :destroy

  accepts_nested_attributes_for :client, reject_if: proc { |attrs| attrs.except(:high_risk, :bank_id).all? { |k, v| v.blank? } }
  accepts_nested_attributes_for :passengers, reject_if: :all_blank
  accepts_nested_attributes_for :invoice, reject_if: :all_blank
  accepts_nested_attributes_for :return, reject_if: :all_blank

  delegate :name, :start_date, :end_date, to: :trip, prefix: true

  validates :quantity, numericality: { greater_than: 0 }, on: :update
  validate :seats_over_limit, on: :update

  before_save :generate_reference, if: :reserved?

  ransacker(:created_at_date, type: :date) { |parent| Arel::Nodes::SqlLiteral.new "date(bookings.created_at)" }

  scope :active, -> { joins(:trip).merge(Trip.valid) }


  def reserve(expiring_on)
    SeatingAssigner.new(self).assign
    self.expiry_date = expiring_on
    self.status = :reserved
  end

  def is_return?
    self.main_id?
  end

  private
    def defaults
      { status: :in_process }
    end

    def seats_over_limit
        available_seats = self.stop.available_seats
        self.errors.add(:base,"There are not enough seats (#{available_seats}) available for this booking (#{self.quantity}).") unless available_seats >= self.quantity
    end

  protected
    def generate_reference
      self.reference_no = "#{self.created_at.strftime('%Y%m%d')} #{self.client.full_name} #{SecureRandom.hex(2)}".gsub(/\s+/, "") unless self.reference_no.present?
    end
end
