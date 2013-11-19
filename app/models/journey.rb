# == Schema Information
#
# Table name: journeys
#
#  id         :integer          not null, primary key
#  trip_id    :integer
#  booking_id :integer
#  return     :boolean
#  created_at :datetime
#  updated_at :datetime
#

class Journey < ActiveRecord::Base
  include AttributeDefaults

  belongs_to :trip
  belongs_to :booking

  private
   def defaults
     { return: false}
   end
end
