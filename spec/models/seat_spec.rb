# == Schema Information
#
# Table name: seats
#
#  id         :integer          not null, primary key
#  row        :string(255)
#  number     :integer
#  bus_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Seat do
  pending "add some examples to (or delete) #{__FILE__}"
end
