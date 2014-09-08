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
# Indexes
#
#  index_seats_on_bus_id  (bus_id)
#

require 'rails_helper'

describe Seat, :type => :model do

  it { is_expected.to belong_to(:bus).touch(true) }
  it { is_expected.to validate_presence_of(:row) }
  it { is_expected.to validate_presence_of(:number) }
  it { is_expected.to validate_numericality_of(:number) }



end
