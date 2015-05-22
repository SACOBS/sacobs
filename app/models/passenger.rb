# == Schema Information
#
# Table name: passengers
#
#  id                :integer          not null, primary key
#  name              :character varyin
#  surname           :character varyin
#  booking_id        :integer
#  created_at        :timestamp withou
#  updated_at        :timestamp withou
#  passenger_type_id :integer
#  cell_no           :character varyin
#  email             :character varyin
#  charges           :integer          default([]), is an Array
#
# Indexes
#
#  index_passengers_on_booking_id         (booking_id)
#  index_passengers_on_passenger_type_id  (passenger_type_id)
#

class Passenger < ActiveRecord::Base
  belongs_to :booking
  belongs_to :passenger_type

  after_initialize :set_defaults, if: :new_record?
  before_save :normalize_names

  def full_name
    "#{name} #{surname}"
  end

  def charges
    Charge.find(self[:charges])
  end

  def discount
    Discount.find_by(passenger_type: passenger_type)
  end

  protected

  def set_defaults
    self.passenger_type ||= PassengerType.find_by(description: :standard)
  end

  def normalize_names
    self.name = name.squish.upcase
    self.surname = surname.squish.upcase
  end
end
