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

require 'rails_helper'

describe Passenger, :type => :model do

  it { is_expected.to belong_to(:booking) }
  it { is_expected.to belong_to(:passenger_type) }

  describe 'instance methods' do
    describe '#full_name' do
      it 'returns the full name of the passenger' do
        passenger = build_stubbed(:passenger, name: 'Jim', surname: 'Jones')
        result = passenger.full_name
        expect(result).to eq('Jim Jones')
      end
    end
  end
end
