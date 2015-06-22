# == Schema Information
#
# Table name: passengers
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  surname           :string(255)
#  booking_id        :integer
#  created_at        :datetime
#  updated_at        :datetime
#  passenger_type_id :integer
#  cell_no           :string(255)
#  email             :string(255)
#  charges           :integer          default([]), is an Array
#
# Indexes
#
#  index_passengers_on_booking_id         (booking_id)
#  index_passengers_on_passenger_type_id  (passenger_type_id)
#

class Passenger < ActiveRecord::Base
  DEFAULT_TYPE = PassengerType.find_by(description: :STANDARD)

  belongs_to :booking
  belongs_to :passenger_type

  after_initialize :set_defaults, if: :new_record?

  def full_name
    "#{name} #{surname}"
  end

  def charges
    Charge.find(self[:charges])
  end

  def discount
    Discount.find_by(passenger_type: passenger_type)
  end

  def name=(value)
    super(value.squish.upcase)
  end

  def surname=(value)
    super(value.squish.upcase)
  end

  protected
  def set_defaults
    self.passenger_type = Passenger::DEFAULT_TYPE
  end

end
