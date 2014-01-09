class Setting < ActiveRecord::Base
  include AttributeDefaults


  private
   def defaults
     {booking_expiry_period: 8}
   end
end
