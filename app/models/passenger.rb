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
#

class Passenger < ActiveRecord::Base
  include AttributeDefaults

  belongs_to :booking, touch: true
  belongs_to :passenger_type

  def full_name
    "#{name} #{surname}"
  end

end
