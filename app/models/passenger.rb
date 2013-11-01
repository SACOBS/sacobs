# == Schema Information
#
# Table name: passengers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  surname    :string(255)
#  type       :string(255)
#  booking_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Passenger < ActiveRecord::Base
  belongs_to :booking, touch: true

  def full_name
    "#{name} #{surname}".titleize
  end
end
