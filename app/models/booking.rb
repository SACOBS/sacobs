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
#

class Booking < ActiveRecord::Base
  include AttributeDefaults

  enum :status, [:paid, :reserved, :cancelled, :in_process]

  belongs_to :user
  belongs_to :trip
  belongs_to :client
  has_one :invoice
  has_many :passengers, dependent: :destroy
  has_and_belongs_to_many :stops, autosave: true

  accepts_nested_attributes_for :client, reject_if: :all_blank
  accepts_nested_attributes_for :passengers, reject_if: :all_blank
  accepts_nested_attributes_for :invoice, reject_if: :all_blank

  delegate :name, :start_date, :end_date, to: :trip, prefix: true

  validates :quantity, numericality: { greater_than: 0 }
  validate :seats_over_limit

  before_save :generate_reference, if: :reserved?

  ransacker(:created_at_date, type: :date) { |parent| Arel::Nodes::SqlLiteral.new "date(bookings.created_at)" }

  def expired?
    self.expiry_date <= Time.zone.now
  end

  private
    def defaults
      { status: :in_process }
    end

    def seats_over_limit
      available_seats = self.stops.first.available_seats
      self.errors.add(:base,"There are not enough seats (#{available_seats}) available for this booking (#{self.quantity}).") unless available_seats >= self.quantity
    end

  protected
    def generate_reference
      self.reference_no = "#{self.created_at.strftime('%Y%m%d')} #{self.client.full_name} #{SecureRandom.hex(2)}".gsub(/\s+/, "") unless self.reference_no.present?
    end
end
