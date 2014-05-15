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
  include AttributeDefaults

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

  accepts_nested_attributes_for :client, reject_if: proc { |attrs| attrs.except(:high_risk, :bank_id, :title).all? { |k, v| v.blank? } }
  accepts_nested_attributes_for :passengers, reject_if: :all_blank
  accepts_nested_attributes_for :invoice, reject_if: :all_blank
  accepts_nested_attributes_for :return_booking, reject_if: :all_blank

  delegate :name, :start_date, :end_date, to: :trip, prefix: true

  validates :quantity, numericality: { greater_than: 0 }, on: :update
  validate :seats_over_limit, on: :update, if: :in_process?

  before_save :generate_reference, if: :reserved?
  after_find :check_expiration

  ransacker(:created_at_date, type: :date) { |parent| Arel::Nodes::SqlLiteral.new "date(bookings.created_at)" }

  scope :active, -> { joins(:trip).merge(Trip.valid) }
  scope :standby, -> { reserved.where('expiry_date <= ?', Time.zone.now) }


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
      self.reference_no =  Digest::SHA1.hexdigest([Time.now, rand].join)[0..5].upcase unless reference_no.present?
    end

    def check_expiration
      self.expired = (expiry_date <= Time.zone.now) rescue false
    end
end
