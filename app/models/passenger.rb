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
#
# Indexes
#
#  index_passengers_on_booking_id         (booking_id)
#  index_passengers_on_passenger_type_id  (passenger_type_id)
#

class Passenger < ActiveRecord::Base
  belongs_to :booking
  belongs_to :passenger_type

  delegate :description, to: :passenger_type, prefix: true

  attr_accessor :charge_ids

  before_save :normalize_names

  def full_name
    "#{name} #{surname}"
  end

  protected
  def defaults
    { passenger_type: PassengerType.find_by(description: :standard)}
  end

  def normalize_names
    self.name = name.squish.upcase
    self.surname = surname.squish.upcase
  end
end
