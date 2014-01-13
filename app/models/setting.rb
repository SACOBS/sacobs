# == Schema Information
#
# Table name: settings
#
#  id                    :integer          not null, primary key
#  booking_expiry_period :integer
#  created_at            :datetime
#  updated_at            :datetime
#

class Setting < ActiveRecord::Base
  include AttributeDefaults


  private
   def defaults
     {booking_expiry_period: 8}
   end
end
