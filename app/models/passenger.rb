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
  belongs_to :booking
  belongs_to :passenger_type

  validates :name, :surname, presence: true

  after_initialize :set_defaults, if: :new_record?
  before_save :normalize

  def full_name
    @full_name ||= "#{name} #{surname}"
  end

  def charges
    @charges ||= Charge.find(self[:charges])
  end

  def discount
    @discount ||= (
                    SeasonalDiscount.where(passenger_type: passenger_type)
                    .applicable.first || Discount.find_by(passenger_type: passenger_type)
    )
  end

  private

  def normalize
    self.name = name.squish.upcase
    self.surname = surname.squish.upcase
  end

  def set_defaults
    self.passenger_type = PassengerType.find_by(description: :STANDARD)
  end
end
