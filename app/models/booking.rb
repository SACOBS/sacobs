# == Schema Information
#
# Table name: bookings
#
#  id          :integer          not null, primary key
#  trip_id     :integer
#  price       :decimal(, )
#  status      :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  quantity    :integer          default(0)
#  expiry_date :datetime
#  client_id   :integer
#

class Booking < ActiveRecord::Base
  include AttributeDefaults

  STATUSES = %w(confirmed reserved cancelled processing)
  STATUSES.each do |status|
    define_method("#{status}?") { self.status == status }
    scope status, -> { where(status: status ) }
  end

  belongs_to :trip, touch: true
  belongs_to :client, touch: true
  has_one :invoice
  has_many :passengers, dependent: :destroy
  has_and_belongs_to_many :stops, after_add: :decrement_seats, before_remove: :increment_seats

  accepts_nested_attributes_for :client, reject_if: :all_blank
  accepts_nested_attributes_for :passengers, reject_if: :all_blank
  accepts_nested_attributes_for :invoice, reject_if: :all_blank


  before_create :set_expiry_date

  def cancel
    self.stops.destroy_all
    self.status = 'cancelled'
  end

  private
  def defaults
    { status: 'processing' }
  end

  protected
  def set_expiry_date
    self.expiry_date = Time.zone.now + 24.hours
  end

  def decrement_seats(stop)
     stop.decrement!(:available_seats, self.quantity)
  end

  def increment_seats(stop)
    stop.increment!(:available_seats, self.quantity)
  end

end
