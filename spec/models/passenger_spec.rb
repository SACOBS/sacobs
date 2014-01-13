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
# Indexes
#
#  index_passengers_on_booking_id         (booking_id)
#  index_passengers_on_passenger_type_id  (passenger_type_id)
#

require 'spec_helper'

describe Passenger do
  pending "add some examples to (or delete) #{__FILE__}"
end
