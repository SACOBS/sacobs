# == Schema Information
#
# Table name: settings
#
#  id                    :integer          not null, primary key
#  booking_expiry_period :integer
#  created_at            :datetime
#  updated_at            :datetime
#  ticket_instructions   :string(255)
#  default_scripture     :string(255)
#

class Setting < ActiveRecord::Base
  include AttributeDefaults


  private
   def defaults
     { booking_expiry_period: 25 }
   end
end
