class Journey < ActiveRecord::Base
  include AttributeDefaults

  belongs_to :trip
  belongs_to :booking

  private
   def defaults
     { return: false}
   end
end
