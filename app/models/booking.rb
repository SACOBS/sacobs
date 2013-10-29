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

  STATUSES = %w(confirmed reserved cancelled incomplete)
  STATUSES.each { |status| define_method("#{status}?") { self.status == status } }

  belongs_to :trip, touch: true
  belongs_to :client, touch: true
  has_and_belongs_to_many :stops, after_add: :decrement_seats, before_remove: :increment_seats

  scope :reserved, -> { where(status: :reserved) }
  scope :confirmed, -> { where(status: :confirmed) }

  before_create :set_expiry_date

  def cancel
    self.stops.destroy_all
    self.status = 'cancelled'
  end

  private
  def defaults
    {status: 'reserved'}
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
