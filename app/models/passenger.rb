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

class Passenger < ActiveRecord::Base
  include AttributeDefaults

  belongs_to :booking
  belongs_to :passenger_type

  def full_name
    "#{name} #{surname}"
  end

end
