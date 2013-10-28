# == Schema Information
#
# Table name: bookings
#
#  id          :integer          not null, primary key
#  trip_id     :integer
#  price       :decimal(, )
#  status      :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  quantity    :integer          default(0)
#  expiry_date :datetime
#

require 'spec_helper'

describe Booking do
  pending "add some examples to (or delete) #{__FILE__}"
end
